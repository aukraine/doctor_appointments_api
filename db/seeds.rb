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

Appointment.create(start_time: current_time.to_i, end_time: current_time.to_i + delta_time.to_i)
Appointment.create(start_time: current_time.to_i + delta_time.to_i, end_time: current_time.to_i + delta_time.to_i * 2)

doctor_1 = Doctor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'doctor@mail.com', password: 'password')
doctor_2 = Doctor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')

Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')
Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')
Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')

TimeSlot.create(day_of_week: TimeSlot::MON, doctor: doctor_1, start_time: current_time, end_time: current_time + delta_time)
TimeSlot.create(day_of_week: TimeSlot::WED, doctor: doctor_1, start_time: current_time + three_days, end_time: current_time + three_days + delta_time)
TimeSlot.create(day_of_week: TimeSlot::FRI, doctor: doctor_1, start_time: current_time + five_days, end_time: current_time + five_days + delta_time)
TimeSlot.create(day_of_week: TimeSlot::FRI, doctor: doctor_1, start_time: current_time + five_days + delta_time, end_time: current_time + five_days + delta_time * 2)
TimeSlot.create(day_of_week: TimeSlot::MON, doctor: doctor_2, start_time: current_time, end_time: current_time + delta_time)
TimeSlot.create(day_of_week: TimeSlot::WED, doctor: doctor_2, start_time: current_time + three_days, end_time: current_time + three_days + delta_time)
TimeSlot.create(day_of_week: TimeSlot::FRI, doctor: doctor_2, start_time: current_time + five_days, end_time: current_time + five_days + delta_time)
TimeSlot.create(day_of_week: TimeSlot::FRI, doctor: doctor_2, start_time: current_time + three_days + delta_time, end_time: current_time + three_days + delta_time * 2)
