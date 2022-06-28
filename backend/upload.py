from xml.etree.ElementInclude import include
import pandas_profiling
import glob
import pandas as pd
import os
import numpy as np
from bokeh.plotting import figure, save, gridplot, output_file
from config import *
from pandas.api.types import is_string_dtype, is_numeric_dtype
import matplotlib.pyplot as plt
import seaborn as sns


Filenames = glob.glob(auto_analysis + '/*.csv')

for Filename in Filenames:
    try:
        data = pd.read_csv(Filename, sep='delimiter', error_bad_lines=False)
    except Exception as e:
        print("File - READ"+ e)
        data = pd.read_excel(Filename, sheet_name=None)

    

#pre processing

def preprocessing_csv(data):
    data = reset_index(data)
    data.drop(['index'], axis=1, inplace=True)
    data = data.dropna(axis=0, how='any')
    return data
    
def reset_index(data):
    data.reset_index(inplace=True)
    return data


def add_date_time(df):
    common_date_col = ['Year',"Month","Day","Hour","Minute","Second","Date","Time","Create Date/Time","Recored_Time","DateTime","DateTime_UTC","DateTime_Local","DateTime_Local_UTC","DateTime_Local_UTC_Offset","DateTime_Local_UTC_Offset_Min","DateTime_Local_UTC_Offset_Min_Sec","DateTime_Local_UTC_Offset_Min_Sec_Milli","DateTime_Local_UTC_Offset_Min_Sec_Milli_Micro","DateTime_Local_UTC_Offset_Min_Sec_Milli_Micro_Nano"]
    
    for item in common_date_col:
        for col in df.columns:
            if item == col:
                df[col] = pd.to_datetime(df[col], format="%Y-%m-%d %H:%M:%S")
                df['year']  = df[col].dt.year
                df['month'] = df[col].dt.month
                df['day']   = df[col].dt.day
                df['hour'] = df[col].dt.hour
                df['minute'] = df[col].dt.minute
                df['second'] = df[col].dt.second
                df['day_of_week']  = df[col].dt.dayofweek
                df['date'] = df[col].dt.date
                
                dw_mapping={
                0: 'Monday', 
                1: 'Tuesday', 
                2: 'Wednesday', 
                3: 'Thursday', 
                4: 'Friday',
                5: 'Saturday', 
                6: 'Sunday'
                } 
                df['day_of_week_name'] = df['day_of_week'].map(dw_mapping)
    
    return df

def numeric_data(data): #returns numerical data
    numerics = ['int16', 'int32', 'int64','float64']
    df = data.select_dtypes(include=numerics)
    return df.columns


def categorical_data(data): #returns categorical data
    df =  data.select_dtypes(exclude=['number'])
    return df.columns

#statistics

def describe_data(data):
    return data.describe(include='all') #returns a dataframe

def stats_data(data):
    numerics = ['int16', 'int32', 'int64','float64']
    col = data.select_dtypes(include=numerics).columns  #returns a list of columns with numerical data
    data_stat = {}
    for i in col:
        stat = {i: data.describe()[i][['min','max']].to_list()}
        #add to a dict
        data_stat.update(stat)
    
    frame = pd.DataFrame(data_stat)
    return frame.to_html() #col name #min #max

def get_top_abs_correlations(df, n=5):
    def get_redundant_pairs(df):
        numerics = ['int16', 'int32', 'int64','float64']
        df = df.select_dtypes(include=numerics) 
        '''Get diagonal and lower triangular pairs of correlation matrix'''
        pairs_to_drop = set()
        cols = df.columns
        for i in range(0, df.shape[1]):
            for j in range(0, i+1):
                pairs_to_drop.add((cols[i], cols[j]))
        return pairs_to_drop
    
    au_corr = df.corr().abs().unstack()
    labels_to_drop = get_redundant_pairs(df)
    au_corr = au_corr.drop(labels=labels_to_drop).sort_values(ascending=False)
    return pd.DataFrame(au_corr[0:n]).to_html()


def head(data):
    return data.head(5).to_html()

def tail(data):
    return data.tail(5).to_html()

def columns(data):
    return data.columns

def missng_values(data):
    missing_count = data.isnull().sum() # the count of missing values
    value_count = data.isnull().count() # the count of all values 
    missing_percentage = round(missing_count / value_count * 100,2)
    missing_df = pd.DataFrame({'count': missing_count, 'percentage': missing_percentage}) #create a dataframe        
    return missing_df.to_html()

#graphs
#filename = filepath + name_of_ file
#easiest way to chose the graphs to plot

# Categories = Bar Chart & clustered bar chart & Line Chart & Box Plot 

# Numerical = Histogram & Pie Chart & Stacked Bar Chart & Area Chart & * Scatter Plot & Heatmap


"""#top 10 grphs
plt.figure(column)
plt.title(column)
df[column].plot(kind = 'hist')
df[column].value_counts()[:10].plot(kind ='bar')"""


def heatmap(data,filename): #working
    plt.figure(figsize=(10,10))
    numerics = ['int16', 'int32', 'int64','float64']
    data = data.select_dtypes(include=numerics)
    sns.heatmap(data.corr(), annot=True, cmap='GnBu')
    plt.savefig(filename)
    
def bar_graph(data,path,what="bar"): #or "pie" chart
    
    data = data.head(300)
    
    for column in data:
        plt.figure(column, figsize = (4.9,4.9))
        plt.title(column)
        if is_numeric_dtype(data[column]):
                data[column].plot(kind = 'hist')
        elif is_string_dtype(data[column]):
        # show only the TOP 10 value count in each categorical data
                data[column].value_counts()[:10].plot(kind = what)
                try:
                    plt.savefig(path + column + '_' +what+ '.png')
                except:
                    pass    

def hueplot(data,file_path):
    num_list = []
    cat_list = []

    data = data.head(100)
    
    for column in data:
        if is_numeric_dtype(data[column]):
                num_list.append(column)
        elif is_string_dtype(data[column]):
                cat_list.append(column)
                   
    data = data.head(100)
    for i in range(0, len(cat_list)):
        hue_cat = cat_list[i]
        sns.pairplot(data, hue = hue_cat)
        try:
            plt.savefig(file_path + str(i) + '.png')
        except:
            pass


def boxplot(data,path):
    num_list = []
    cat_list = []

    data = data.head(100)
    
    for column in data:
        if is_numeric_dtype(data[column]):
                num_list.append(column)
        elif is_string_dtype(data[column]):
                cat_list.append(column)
                   
    for i in range(0, len(cat_list)):
        cat = cat_list[i]
        for j in range(0, len(num_list)):
            num = num_list[j]
            plt.figure (figsize = (15,15))
            sns.boxplot( x = cat, y = num, data = data, palette = "GnBu")
            try:
                plt.savefig(path + column + '.png')
            except:
                pass    
                
                
def pairplot(data,filename): #working
    plt.figure(figsize=(10,10))
    sns.pairplot(data, height = 2.5)
    plt.savefig(filename)
    return filename
    


#pandas profiling

def pandas_profiling(filename):
    profile = pandas_profiling.ProfileReport(data, title='Pandas Profiling Report', html={'style':{'full_width':True}})
    profile.to_file(filename)
    return filename,profile.get_html()