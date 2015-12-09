# Flow Main

This is a simulated Flow Works server. It consolidates the data uploaded by various types of _Sensors_ across multiple _Sites_. Each _Sensor_ has a warning and danger threshold. A _Notification_ is triggered every time a _Sensor_ value meets, exceeds or falls below their threshold.

The server has the following tables and columns:

1. Sites
  - name
  - lon
  - lat
  - description
2. Sensors
  - name
  - sensor_type
  - description
  - warning_threshold
  - danger_threshold
  - site_id
3. Scadas
  - value
  - ts_data
  - sensor_id
4. Notifications
  - status
  - error
  - ts_data
  - sensor_id

The following paths are available:

1. http://localhost:3000/api/v1/sites/
2. http://localhost:3000/api/v1/sensors/
3. http://localhost:3000/api/v1/scadas/
4. http://localhost:3000/api/v1/notifications/
5. http://localhost:3000/api/v1/GetListPerSite/(sensor_id)
6. http://localhost:3000/api/v1/SensorInfo/(sensor_id)
7. http://localhost:3000/api/v1/SensorStatus/(sensor_id)

#### Sample JSON response from the server.
```
{
sites: [
{
id: 1,
name: "Lynn Creek",
lon: -123.0312098,
lat: 49.3452601,
description: null,
url: "/api/v1/sites/1",
sensors: [
          {
          id: 1,
          name: "Water Displacement",
          sensor_type: 1,
          description: "m3/s",
          warning_threshold: 300,
          danger_threshold: 400,
          site_id: 1,
          scadas: [],
          notifications: []
          },
          {
          id: 2,
          name: "Temperature",
          sensor_type: 2,
          description: "Celcius",
          warning_threshold: 21,
          danger_threshold: 32,
          site_id: 1,
          scadas: [],
          notifications: []
          }
          ]
},
```

#### Sample Scada JSON response.
```
{
scada: {
id: 1,
value: 386,
ts_data: "2015-11-18 11:52:27 -0800",
sensor_id: 1
}
}
```

#### Sample Notification JSON response.
```
{
notification: {
id: 1,
error: "",
ts_data: "2015-11-18 11:52:27 -0800",
sensor_id: 1
}
}
```
