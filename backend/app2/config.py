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

event_type = ['Information Against Police', 'Threat In Person', 'Dispute',
       'Gambling', 'Missing', 'Theft', 'Domestic Violence',
       'Property Disputes', 'Illegal Mining', 'Suicide', 'Corona',
       'Cyber Crimes', 'Female Sexual Harrassment',
       'Unclaimed Information', 'Encroachment',
       'Crime On Phone Mobile Social Media Internet', 'Animals Related',
       'Unknown', 'Robbery', 'Pollution',
       'Information Against Other Government Departments', 'Medium Fire',
       'Child Crime(Sexual Abuse)', 'Found Deadbody',
       'Suspicious Object Information',
       'Threat On Phone Email Social Media', 'Dacoity',
       'Attempted Murder', 'Suspicious Person Information', 'Forgery',
       'Female Harrassment', 'Kidnap', 'Excise Act Offenses', 'Accident',
       'Ndps Act Offenses', 'Police Help Required By 108',
       'Escort For Safety', 'Traffic Jam', 'Differently Abled People',
       'Sos', 'Murder', 'Assault/Riot/Commotion', 'Major Fire',
       'Child Crime', 'Dowry Related Crime', 'Small Fire', 'Pick Pocket',
       'Election Offences-Violation Of Model Code Of Conduct',
       'Animals Smugling', 'Accident Explosive', 'Personally Threat',
       'Human Trafficking', 'Police Help Required By 1090',
       'Suicide Attempt'] 

event_type_test = ["Suspicious Object Information","Threat In Person","Attempted Murder","Domestic Violence","Female Harrassment","Dispute"]