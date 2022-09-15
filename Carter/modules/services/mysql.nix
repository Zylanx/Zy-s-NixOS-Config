{ config, pkgs, ... }:
{
    config = {
        services.mysql =
        {
            enable = true;
            package = pkgs.mysql80;

            initialDatabases = [
                {
                    name = "aftershockpc";
                }
            ];

            ensureDatabases = [ "aftershockpc" ];

            ensureUsers =[
                {
                    name = "zyl";
                    ensurePermissions = { "*.*" = "ALL PRIVILEGES"; };
                }
            ];

            initialScript = pkgs.writeText "mysql-create-test-user.sql" ''
                CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpassword';
                GRANT ALL PRIVILEGES ON *.* TO 'testuser'@'localhost';
                FLUSH PRIVILEGES;
            '';
        };
    };
}
