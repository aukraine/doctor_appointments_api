# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
Appointment.destroy_all
User.destroy_all
TimeSlot.destroy_all

current_time = Time.current + 2.hours
delta_time = 20.minutes
one_day = 1.day
three_days = one_day * 3
five_days = one_day * 5

doctor_1 = FactoryBot.create(:doctor, email: 'doctor@mail.com')
doctor_2 = FactoryBot.create(:doctor)

patient_1 = FactoryBot.create(:patient, email: 'patient@mail.com')
patient_2 = FactoryBot.create(:patient)

slot_1 = FactoryBot.create(:time_slot, :booked, doctor: doctor_1, start_time: current_time)
slot_2 = FactoryBot.create(:time_slot, doctor: doctor_1, start_time: current_time + three_days, day_of_week: TimeSlot::WED)
slot_3 = FactoryBot.create(:time_slot, :booked, doctor: doctor_1, start_time: current_time + five_days, day_of_week: TimeSlot::FRI)
slot_4 = FactoryBot.create(:time_slot, :booked, doctor: doctor_1, start_time: current_time + five_days + delta_time, day_of_week: TimeSlot::FRI)
slot_5 = FactoryBot.create(:time_slot, doctor: doctor_2, start_time: current_time)
slot_6 = FactoryBot.create(:time_slot, :booked, doctor: doctor_2, start_time: current_time + three_days, day_of_week: TimeSlot::WED)
slot_7 = FactoryBot.create(:time_slot, :booked, doctor: doctor_2, start_time: current_time + three_days + delta_time, day_of_week: TimeSlot::WED)
slot_8 = FactoryBot.create(:time_slot, doctor: doctor_2, start_time: current_time + five_days, day_of_week: TimeSlot::FRI)

FactoryBot.create(:appointment, patient: patient_1, time_slot: slot_1)
FactoryBot.create(:appointment, patient: patient_1, time_slot: slot_4)
FactoryBot.create(:appointment, patient: patient_1, time_slot: slot_6)
FactoryBot.create(:appointment, patient: patient_2, time_slot: slot_3)
FactoryBot.create(:appointment, patient: patient_2, time_slot: slot_7)
