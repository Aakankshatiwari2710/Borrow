package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("org.postgresql.Driver");
            
            // Get database credentials from Environment Variables (for Render/Supabase)
            String dbUrl = System.getenv("DB_URL");
            String dbUser = System.getenv("DB_USER");
            String dbPassword = System.getenv("DB_PASSWORD");
            
            // Fallback for local development (Neon)
            if (dbUrl == null || dbUrl.trim().isEmpty()) {
                dbUrl = "jdbc:postgresql://ep-soft-sunset-am6a2oz3-pooler.c-5.us-east-1.aws.neon.tech/neondb?sslmode=require";
            }
            if (dbUser == null) dbUser = "neondb_owner";
            if (dbPassword == null) dbPassword = "npg_pjg4b6GydBiv";
            
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            System.out.println("Database Connected Successfully");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
