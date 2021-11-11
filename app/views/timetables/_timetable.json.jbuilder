json.extract! timetable, :id, :subject_id, :day, :start_time, :end_time, :created_at, :updated_at
json.url timetable_url(timetable, format: :json)
