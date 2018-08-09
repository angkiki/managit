# manaGit

### TODO:
* Rspec (TDD)
* Users (Devise)
* User -> has_many -> Projects, through: project_users
* Projects -> has_many -> Users, through: project_users
* join_table -> project_users -> belongs_to :user, :project
* User -> has_many -> Features
* Project -> has_many -> Features

### Schema:
* Users: (defaults, username:string[unique])
* Projects: (title:string, owner:integer)
* ProjectUsers: (user:references, project:references, status:integer[enum] -> default: 0)
* Features: (status:integer[enum], name:string, project:references, user:references)
