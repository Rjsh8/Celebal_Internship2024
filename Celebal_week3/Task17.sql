CREATE LOGIN new_user_login WITH PASSWORD = 'StrongPassword123!';

CREATE USER new_user FOR LOGIN new_user_login;

EXEC sp_addrolemember 'db_owner', 'new_user';
