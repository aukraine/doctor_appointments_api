# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
Appointment.destroy_all
User.destroy_all
DoctorAvailability.destroy_all

current_time = Time.current.to_i
delta_time = 20.minutes.to_i
one_day = 1.day.to_i
three_days = one_day * 3
five_days = one_day * 5

Appointment.create(start_time: current_time, end_time: current_time + delta_time)
Appointment.create(start_time: current_time + delta_time, end_time: current_time + delta_time * 2)

doctor_1 = Doctor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'doctor@mail.com', password: 'password')
doctor_2 = Doctor.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')

Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')
Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')
Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password')

DoctorAvailability.create(
  day_of_week: DoctorAvailability::DAYS_OF_WEEK[DoctorAvailability::MON],
  doctor: doctor_1,
  start_time: current_time,
  end_time: current_time + delta_time
)
DoctorAvailability.create(
  day_of_week: DoctorAvailability::DAYS_OF_WEEK[DoctorAvailability::WED],
  doctor: doctor_1,
  start_time: current_time + three_days,
  end_time: current_time + three_days + delta_time
)
DoctorAvailability.create(
  day_of_week: DoctorAvailability::DAYS_OF_WEEK[DoctorAvailability::FRI],
  doctor: doctor_1,
  start_time: current_time + five_days,
  end_time: current_time + five_days + delta_time
)
DoctorAvailability.create(
  day_of_week: DoctorAvailability::DAYS_OF_WEEK[DoctorAvailability::FRI],
  doctor: doctor_1,
  start_time: current_time + five_days + delta_time,
  end_time: current_time + five_days + delta_time * 2
)
DoctorAvailability.create(
  day_of_week: DoctorAvailability::DAYS_OF_WEEK[DoctorAvailability::MON],
  doctor: doctor_2,
  start_time: current_time,
  end_time: current_time + delta_time
)
DoctorAvailability.create(
  day_of_week: DoctorAvailability::DAYS_OF_WEEK[DoctorAvailability::MON],
  doctor: doctor_2,
  start_time: current_time,
  end_time: current_time + delta_time
)
DoctorAvailability.create(
  day_of_week: DoctorAvailability::DAYS_OF_WEEK[DoctorAvailability::WED],
  doctor: doctor_2,
  start_time: current_time + three_days,
  end_time: current_time + three_days + delta_time
)
DoctorAvailability.create(
  day_of_week: DoctorAvailability::DAYS_OF_WEEK[DoctorAvailability::WED],
  doctor: doctor_2,
  start_time: current_time + three_days + delta_time,
  end_time: current_time + three_days + delta_time * 2
)
