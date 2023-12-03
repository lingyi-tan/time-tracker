import streamlit as st
import pandas as pd

st.title('Time tracker')

st.write('What are you doing right now?')

categories = ['Agathe', 'Reading', 'Writing', 'Coding', 'Swedish', 'Learning', 'Other']
main_activity = st.text_input('1. Main activity')
main_category = st.selectbox('Main category', categories)

secondary_activity = st.text_input('2. Secondary activity')
secondary_category = st.selectbox('Second category', categories)

if st.button('Submit'):
    st.write('Submitted')

# some visualization of the current breakdown
# collect info and send it to a database