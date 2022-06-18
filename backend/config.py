import os
basepath = os.path.dirname(os.path.realpath(__file__))

model_path = os.path.join(basepath,"models","violent_crime.sav") 

model_path_2 = os.path.join(basepath,"models","predict_crime")

upload = os.path.join(basepath,"static")


temp_path = basepath.split("/")
temp_path.remove("backend")
basepath2 = '/'.join(temp_path)


graph1 = os.path.join(basepath2,"data","graphs","001_most_freq_event.json")
graph2 = os.path.join(basepath2,"data","graphs","002_no_event_updated_by_date.json")
graph3 = os.path.join(basepath2,"data","graphs","003_no_event_updated_by_days.json")
graph4 = os.path.join(basepath2,"data","graphs","004_no_event_updated_by_hour.json")
graph5 = os.path.join(basepath2,"data","graphs","005_event_byevent_type_001.json")
graph6 = os.path.join(basepath2,"data","graphs","006_event_by_hour_002.json")
graph7 = os.path.join(basepath2,"data","graphs","007_scatter_plot_peek_time_crime.json")
graph8 = os.path.join(basepath2,"data","graphs","008_no_of_cases_in_important_event_type.json")