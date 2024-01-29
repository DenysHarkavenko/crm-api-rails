# Rails API for CRM

## How to run ?
### 1) First step:
```
bundle install
```
### 2) Next step
```
rake db:create
rake db:migrate
```
### 3) Run server
```
rails s
```


You must use your email and token to access the api. The token can be obtained in this way:

For create USER (POST):
> http://127.0.0.1:3000/users
and raw info in json
```
{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
```
For check your token (POST):
> http://127.0.0.1:3000/api/sessions
and body
```
email: 'your user email'
password: 'your user password'
```
### If it's doesn't work, you can make this manual in Rails Console:
```
user = User.new(email: 'email@email.com', password: 'password')
user.save
```

Further, to work with the api, you will have to use such headers all the time:
```
X-User-Email: 'your user email'
X-User-Token: 'your user token'
```

For GET projects (GET):
> http://127.0.0.1:3000/api/projects

For CREATE project (POST):
> http://127.0.0.1:3000/api/projects
```
{
  "project": {
    "name": "Project name",
    "description": "Project description"
  }
}
```

For DELETE project (DELETE):
> http://127.0.0.1:3000/api/projects/PROJECT_ID

For UPDATE project (PUT/PATCH):
> http://127.0.0.1:3000/api/projects/PROJECT_ID
```
{
  "project": {
     "name": "New project name",
     "description": "New project description"
   }
}
```

And it's still the same for tasks:

For GET tasks for some project (GET):
> http://127.0.0.1:3000/api/projects/PROJECT_ID/tasks

For CREATE task (POST):
> http://127.0.0.1:3000/api/projects/PROJECT_ID/tasks
```
{
  "task": {
    "name": "Some task",
    "description": "Update something",
    "status": "Under Review"
  }
}
```

For DELETE task (DELETE):
> http://127.0.0.1:3000/api/projects/PROJECT_ID/tasks/TASK_ID
