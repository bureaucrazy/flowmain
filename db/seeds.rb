# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


CREATED_AT = Time.now
# Site table
# -----------------------------------------------------------------------
CLIENT_ID = 1
SITE_ARY_NAME  = ['Lynn Creek', 'Seymour River', 'Cleveland Dam', 'Capilano River', 'Fraser River']
SITE_ARY_LAT   = [49.3452601, 49.346578, 49.3602866, 49.327318, 49.177778]
SITE_ARY_LON  = [-123.0312098, -123.00334, -123.111918, -123.131257, -123.2125]

for site_ary_ctr in 0...SITE_ARY_NAME.count
  Site.create({name: SITE_ARY_NAME[site_ary_ctr],
               lat:  SITE_ARY_LAT[site_ary_ctr],
               lon: SITE_ARY_LON[site_ary_ctr],
               client_id: CLIENT_ID,
               created_at: CREATED_AT})
end
# -----------------------------------------------------------------------


# Sensor table
# -----------------------------------------------------------------------
SENSOR_ARY_NAME = ['Water Displacement', 'Temperature', 'Flow', 'Level']
SENSOR_ARY_TYPE = [1, 2, 3, 4]
SENSOR_ARY_DESCRIPTION = ['m3/s', 'Celcius', 'Gallons/second', 'Meters']
SENSOR_ARY_WARNING = [300, 21, 21, 50]
SENSOR_ARY_DANGER = [400, 32, 32, 75]

for site_ary_ctr in 1..SITE_ARY_NAME.count
  for sensor_ary_ctr in 0...SENSOR_ARY_NAME.count
    Sensor.create({name: SENSOR_ARY_NAME[sensor_ary_ctr],
                   sensor_type: SENSOR_ARY_TYPE[sensor_ary_ctr],
                   description: SENSOR_ARY_DESCRIPTION[sensor_ary_ctr],
                   warning_threshold: SENSOR_ARY_WARNING[sensor_ary_ctr],
                   danger_threshold: SENSOR_ARY_DANGER[sensor_ary_ctr],
                   site_id: site_ary_ctr,
                   created_at: CREATED_AT})
  end
end
# -----------------------------------------------------------------------

# Scada table
# -----------------------------------------------------------------------
STARTING_DATE = Time.now - 1.day
LIQUID      = 1
TEMPERATURE = 2
FLOW        = 3
LEVEL       = 4

# Sensor level loop
for sensor_id in 1..Sensor.count
  sensor            = Sensor.find(sensor_id)
  sensor_type       = sensor.sensor_type
  liquid_start      = rand(150..200)
  liquid_peak       = rand(290..450)
  liquid_end        = rand(150..290)
  temperature_start = rand(4..10)
  temperature_peak  = rand(10..25)
  temperature_end   = rand(4..10)
  flow_start        = rand(2..10)
  flow_peak         = rand(10..25)
  flow_end          = rand(2..10)
  level_start       = rand(15..20)
  level_peak        = rand(20..80)
  level_end         = rand(15..20)

  # Scada level loop
  starting_date_as_ctr = STARTING_DATE
  until starting_date_as_ctr > Time.now
    time_to_check = starting_date_as_ctr.strftime("%H").to_i
    case sensor_type
    when LIQUID
      if time_to_check >= 4 && time_to_check <= 10
        value = (liquid_start * time_to_check) / 5
      elsif time_to_check >= 11 && time_to_check <= 16
        value = liquid_peak
      else
        value = (liquid_end * time_to_check) / 5
      end
    when TEMPERATURE
      if time_to_check >= 4 && time_to_check <= 10
        value = (temperature_start * time_to_check) / 4
      elsif time_to_check >= 11 && time_to_check <= 16
        value = temperature_peak
      else
        value = (temperature_end * time_to_check) / 6
      end
    when FLOW
      if time_to_check >= 4 && time_to_check <= 10
        value = (flow_start * time_to_check) / 5
      elsif time_to_check >= 11 && time_to_check <= 16
        value = flow_peak
      else
        value = (flow_end * time_to_check) / 5
      end
    when LEVEL
      if time_to_check >= 4 && time_to_check <= 10
        value = (level_start * time_to_check) / 3
      elsif time_to_check >= 11 && time_to_check <= 16
        value = level_peak
      else
        value = (level_end * time_to_check) / 4
      end
    end

    Scada.create({sensor_id:  sensor_id,
                  value:      value,
                  ts_data:    starting_date_as_ctr,
                  created_at: CREATED_AT})

    # Notification
    if value >= sensor.danger_threshold
      status = 3
    else
      if value >= sensor.warning_threshold
        status = 2
      else
        status = 1
      end
    end

    Notification.create({sensor_id:  sensor_id,
                         status:     status,
                         error:      '',
                         ts_data:    starting_date_as_ctr,
                         created_at: CREATED_AT})

    previous_value = value
    starting_date_as_ctr += 15.minutes
  end
end
# -----------------------------------------------------------------------
