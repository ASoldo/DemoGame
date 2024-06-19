# How to setup godot project to git

### To set up a Godot project with Git, follow these steps

- Create a new Godot project: Open Godot and create a new project. Choose the project type, project name, and project location.
- Initialize the Git repository: Open the terminal or command prompt and navigate to the project directory. Run the command `git init` to initialize the Git repository.
- Add the files to the Git repository: Run the command `git add .` to add all the files in the project directory to the Git repository.
- Commit the changes: Run the command `git commit -m "Initial commit"` to commit the changes with a meaningful commit message.
- Create a remote repository: Create a new repository on a Git hosting platform such as GitHub or GitLab. Copy the repository URL.
- Link the local repository to the remote repository: Run the command `git remote add origin <repository_url>` to link the local repository to the remote repository.
- Push the changes to the remote repository: Run the command `git push -u origin master` to push the changes to the remote repository.
- Tracking binary files with Git LFS

- If your Godot project contains large binary files, you may want to use Git LFS (Large File Storage) to track them. Here’s how:

- Install Git LFS: Run the command `git lfs install` to install Git LFS.
- Track the binary files: Run the command `git lfs track "assets/**"` to track the binary files in the Assets directory and its subdirectories.
- Add the tracked files to the Git repository: Run the command `git add .` to add the tracked files to the Git repository.
- Commit the changes: Run the command `git commit -m "Added binary files"` to commit the changes with a meaningful commit message.
- Push the changes to the remote repository: Run the command `git push -u origin master` to push the changes to the remote repository.
