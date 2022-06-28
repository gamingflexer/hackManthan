from xml.etree.ElementInclude import include
import pandas_profiling
import glob
import pandas as pd
import os
import numpy as np
from bokeh.plotting import figure, save, gridplot, output_file
from config import *
import matplotlib.pyplot as plt
import seaborn as sns


Filenames = glob.glob(auto_analysis + '/*.csv')

for Filename in Filenames:

    data = pd.read_csv(Filename, sep='delimiter', error_bad_lines=False)
    

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


def heatmap(data,filename):
    plt.figure(figsize=(10,10))
    numerics = ['int16', 'int32', 'int64','float64']
    data = data.select_dtypes(include=numerics)
    sns.heatmap(data.corr(), annot=True, cmap='GnBu')
    plt.savefig(filename)
    
def bar_graph(df,x,y,filename,title="Bar Graph"):
    p = figure(title=title, plot_width=1000, plot_height=600, x_axis_label=x, y_axis_label=y)
    p.vbar(x=x, top=y, width=0.5, source=df)
    save(p, filename=filename)
    return filename

def pie_chart(label_actual,label_values,filename):
    explode=[0.3,0.2,0]
    color=["c", "b", "r"]
    textprops={"fontsize":15}
    plt.pie(label_values,labels=label_actual, explode=explode,colors = color,autopct="%0.3f%%"
            ,shadow=True,radius=1.4,startangle=270,textprops = textprops)
    plt.savefig(filename)
    return filename

def pairplot(data,filename):
    plt.figure(figsize=(10,10))
    sns.pairplot(data, height = 2.5)
    plt.savefig(filename)
    return filename
    


#pandas profiling

def pandas_profiling(filename):
    profile = pandas_profiling.ProfileReport(data, title='Pandas Profiling Report', html={'style':{'full_width':True}})
    profile.to_file(filename)
    return filename,profile.get_html()