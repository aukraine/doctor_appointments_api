# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
Appointment.destroy_all

current_time = Time.current.to_i
delta_time = 1200

Appointment.create(start_time: current_time, end_time: current_time + delta_time)
Appointment.create(start_time: current_time + delta_time, end_time: current_time + delta_time * 2)
