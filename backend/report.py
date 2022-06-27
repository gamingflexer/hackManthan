from turtle import heading
from jinja2 import Environment,FileSystemLoader
from upload import *

# html to pdf
# import pdfkit
# pdfkit.from_file('output.html', 'output.pdf')

#some pre processing
data = pd.read_csv("/Users/cosmos/Desktop/HackManthan/hackManthan/python/data.csv")
data = preprocessing_csv(data)
data = reset_index(data)
# data = add_date_time(data) # add after corrlection

# create a jinja2 environment

env = Environment(loader=FileSystemLoader('templates'))

#load a template

template = env.get_template('report.html')

# render the template with variables

# 4. Render the template with variables
html = template.render(heading= "Origin Custom Report",
                       data_head=head(data),
                       data_tail= tail(data),
                       data_columns = columns(data),
                       data_minMax = stats_data(data),
                       data_correlation = get_top_abs_correlations(data),
                       data_numeric = numeric_data(data),
                       data_categorical = categorical_data(data)
                       #add graphs function from here)
)
                       

# 5. Write the template to an HTML file
with open('/Users/cosmos/Desktop/HackManthan/hackManthan/backend/static/Reports/html_report_jinja.html', 'w') as f:
    f.write(html)