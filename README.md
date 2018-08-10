# manaGit

### TODO:
1. User registration and login [done]
2. Create dashboard for users (change after_sign_in_path for devise) [done]
3. Display projects on dashboard (display current projects & pending invitations)
4. Create new projects
5. Invite other users to project
6. Create new features
7. Assign features to users
8. Update status of features that belongs to user

### Completed:
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
