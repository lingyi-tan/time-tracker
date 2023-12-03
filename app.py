from dataclasses import dataclass
import streamlit as st
import pandas as pd
from datetime import datetime

st.title('Time tracker')

st.write('What are you doing right now?')


@dataclass
class Record:
    main_category: str
    main_activity: str
    secondary_category: str
    secondary_activity: str
    focus: int
    time: datetime = datetime.now()
    
if 'data' not in st.session_state:
    st.session_state['data'] = []

categories = ['Agathe', 'Reading', 'Writing', 'Coding', 'Swedish', 'Learning', 'Other']

with st.form('my_form', clear_on_submit=True, border=True):

    main_category = st.selectbox('1. Main activity', categories)
    main_activity = st.text_area('Main activity description')
    
    secondary_category = st.selectbox('2. Secondary activity', categories)
    secondary_activity = st.text_area('Secondary activity description')
    focus = st.slider('Focus', min_value=0, max_value=100, value=60, step=5)
    
    if st.form_submit_button('Submit'):
        st.session_state['data'].append(Record(
            main_activity=main_activity,
            main_category=main_category,
            secondary_activity=secondary_activity,
            secondary_category=secondary_category,
            focus=focus
        ))

        st.write('Submitted')

if st.session_state['data'] != []:
    df = pd.DataFrame(st.session_state['data'])
    df = df.set_index('time')
    st.table(df)



# some visualization of the current breakdown
# collect info and send it to a database