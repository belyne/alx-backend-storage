#!/usr/bin/env python3
"""
Returns all students sorted by average score.
"""
from pymongo import MongoClient

def top_students(mongo_collection):
    students = list(mongo_collection.find())

    for student in students:
        total_score = sum(topic['score'] for topic in student['topics'])
        average_score = total_score / len(student['topics']) if len(student['topics']) > 0 else 0
        student['averageScore'] = round(average_score, 2)

    return sorted(students, key=lambda x: x['averageScore'], reverse=True)

if __name__ == "__main__":
    client = MongoClient('mongodb://127.0.0.1:27017')
    students_collection = client.my_db.students

    # Your test data
    j_students = [
        {'name': "John", 'topics': [{'title': "Algo", 'score': 10.3}, {'title': "C", 'score': 6.2}, {'title': "Python", 'score': 12.1}]},
        {'name': "Bob", 'topics': [{'title': "Algo", 'score': 5.4}, {'title': "C", 'score': 4.9}, {'title': "Python", 'score': 7.9}]},
        {'name': "Sonia", 'topics': [{'title': "Algo", 'score': 14.8}, {'title': "C", 'score': 8.8}, {'title': "Python", 'score': 15.7}]},
        {'name': "Amy", 'topics': [{'title': "Algo", 'score': 9.1}, {'title': "C", 'score': 14.2}, {'title': "Python", 'score': 4.8}]},
        {'name': "Julia", 'topics': [{'title': "Algo", 'score': 10.5}, {'title': "C", 'score': 10.2}, {'title': "Python", 'score': 10.1}]},
    ]

    for j_student in j_students:
        insert_school(students_collection, **j_student)

    students = list_all(students_collection)
    for student in students:
        print("[{}] {} - {}".format(student.get('_id'), student.get('name'), student.get('topics')))

    top_students = top_students(students_collection)
    for student in top_students:
        print("[{}] {} => {}".format(student.get('_id'), student.get('name'), student.get('averageScore')))
