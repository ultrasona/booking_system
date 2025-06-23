# BookingSystem

## Prerequisites
-   Ruby `>= 3.0`
-   Rails `>= 7`
-   PostgreSQL

## Install

### Clone the repository
With https:
```
git clone https://github.com/ultrasona/booking_system.git
```
Or ssh:
```
git@github.com:ultrasona/booking_system.git
```

### Start project ecosystem
The project include a `docker-compose.yml` file that contains definitions for PostgreSQL, you can start it easily using

```
# Start PostgreSQL and Kafka server

docker-compose up
```

### Set up the project
- Install the different gems
`bundle install`

- Create, migrate and put seeds into db
`rails db:create db:migrate db:seed`

- Launch tests
`bundle exec rspec`

- Launch server
`rails s`


## Routes

### Book a room

**POST /rooms/:room_id/bookings**

#### cURL example
```bash
curl -X POST http://localhost:3000/rooms/1/bookings \
  -H "Content-Type: application/json" \
  -d '{
    "booking": {
      "start_at": "2025-06-25T10:00:00Z",
      "end_at": "2025-06-25T12:00:00Z"
    },
    "user_id": 1
  }'
  ```

#### Success

```json
{
   "id":  1,
   "start_at":  "2025-06-25T10:00:00Z",
   "end_at":  "2025-06-25T12:00:00Z",
   "user_id":  1,
   "room_id":  1,
   "created_at":  "2025-06-23T08:00:00Z",
   "updated_at":  "2025-06-23T08:00:00Z"
 }
```

#### Error (room already booked)

```json
{  "error":  "La salle est déjà réservée sur ce créneau"  }
```

### Check user's booking

**GET /users/:user_id/bookings**

#### cURL example
```bash
curl http://localhost:3000/users/1/bookings
  ```

#### Success

```json
[
  {
    "id": 1,
    "start_at": "2025-06-25T10:00:00Z",
    "end_at": "2025-06-25T12:00:00Z",
    "room_id": 1
  }
]
```

#### Error (user not found)

```json
{
 "error": "User not found"
}
```

### List all rooms available at a certain date and time, with specific equipments

**GET /rooms/available**

#### cURL example
```bash
curl "http://localhost:3000/rooms/available?start_at=2025-06-25T10:00:00Z&end_at=2025-06-25T12:00:00Z&equipment_ids[]=1&equipment_ids[]=2"
  ```

#### Success

```json
[
  {
    "id": 1,
    "name": "Room A",
    "capacity": 10,
    "created_at": "2025-06-23T08:00:00Z",
    "updated_at": "2025-06-23T08:00:00Z"
  }
]
```

#### Error (missing info)

```json
{
  "error": "start_at et end_at sont requis"
}
```
