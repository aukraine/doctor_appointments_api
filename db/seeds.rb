# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
Appointment.destroy_all
User.destroy_all
TimeSlot.destroy_all

current_time = Time.current
delta_time = 20.minutes
one_day = 1.day
three_days = one_day * 3
five_days = one_day * 5

doctor_1 = Doctor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'doctor@mail.com', password: 'password')
doctor_2 = Doctor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')

patient_1 = Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')
patient_2 = Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')

slot_1 = TimeSlot.create(day_of_week: TimeSlot::MON, doctor: doctor_1, start_time: current_time, end_time: current_time + delta_time)
slot_2 = TimeSlot.create(day_of_week: TimeSlot::WED, doctor: doctor_1, start_time: current_time + three_days, end_time: current_time + three_days + delta_time)
slot_3 = TimeSlot.create(day_of_week: TimeSlot::FRI, doctor: doctor_1, start_time: current_time + five_days, end_time: current_time + five_days + delta_time)
slot_4 = TimeSlot.create(day_of_week: TimeSlot::FRI, doctor: doctor_1, start_time: current_time + five_days + delta_time, end_time: current_time + five_days + delta_time * 2)
slot_5 = TimeSlot.create(day_of_week: TimeSlot::MON, doctor: doctor_2, start_time: current_time, end_time: current_time + delta_time)
slot_6 = TimeSlot.create(day_of_week: TimeSlot::WED, doctor: doctor_2, start_time: current_time + three_days, end_time: current_time + three_days + delta_time)
slot_7 = TimeSlot.create(day_of_week: TimeSlot::FRI, doctor: doctor_2, start_time: current_time + five_days, end_time: current_time + five_days + delta_time)
slot_8 = TimeSlot.create(day_of_week: TimeSlot::FRI, doctor: doctor_2, start_time: current_time + three_days + delta_time, end_time: current_time + three_days + delta_time * 2)

Appointment.create(patient: patient_1, time_slot: slot_1, start_time: slot_1.start_time, end_time: slot_1.end_time, description: Faker::Lorem.sentence)
Appointment.create(patient: patient_1, time_slot: slot_4, start_time: slot_4.start_time, end_time: slot_4.end_time, description: Faker::Lorem.sentence)
Appointment.create(patient: patient_1, time_slot: slot_6, start_time: slot_6.start_time, end_time: slot_6.end_time, description: Faker::Lorem.sentence)
Appointment.create(patient: patient_2, time_slot: slot_3, start_time: slot_3.start_time, end_time: slot_3.end_time, description: Faker::Lorem.sentence)
Appointment.create(patient: patient_2, time_slot: slot_8, start_time: slot_8.start_time, end_time: slot_8.end_time, description: Faker::Lorem.sentence)
