import os
import pandas as pd

directory = 'course-wise-students-list'
final_df = pd.DataFrame(columns=['serial_number', 'cid', 'roll_number', 'name', 'email'])

for dept in os.listdir(directory):
    print(dept)
    for course in os.listdir(os.path.join(directory, dept)):
        print(course)
        df = pd.read_csv(os.path.join(directory, dept, course), encoding="latin", names=['serial_number', 'roll_number', 'name', 'email'])
        df['cid'] = course[:course.index('.')]
        final_df = pd.concat([final_df, df], axis=0)

final_df.to_csv('merged_data.csv', index=False)