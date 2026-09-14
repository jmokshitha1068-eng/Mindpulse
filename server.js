const express = require("express");
const path = require("path");
const { Pool } = require("pg");

const app = express();
const PORT = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(__dirname));


// ===============================
// PostgreSQL Database Connection
// ===============================

const pool = new Pool({
    user: "postgres",
    host: "localhost",
    database: "MindPulse",
    password: "kittu",
    port: 5432
});


// Check database connection
pool.query("SELECT NOW()")
    .then(() => {
        console.log("PostgreSQL connected successfully");
    })
    .catch((error) => {
        console.error("PostgreSQL connection failed:", error.message);
    });


// ===============================
// Home Page
// ===============================

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "mindpulse.html"));
});


// ===============================
// Health Check
// ===============================

app.get("/api/health", async (req, res) => {
    try {
        await pool.query("SELECT 1");

        res.json({
            success: true,
            message: "MindPulse backend and database are running"
        });

    } catch (error) {

        console.error("Health check error:", error.message);

        res.status(500).json({
            success: false,
            message: "Database connection failed"
        });
    }
});


// ===============================
// SAVE CHECK-IN
// ===============================

app.post("/api/checkins", async (req, res) => {

    const client = await pool.connect();

    try {

        const {
            userId = 1,
            userName,
            userAge,
            totalScore,
            stressLevel
        } = req.body;


        // Check required information

        if (
            !userName ||
            !userAge ||
            totalScore === undefined ||
            !stressLevel
        ) {

            return res.status(400).json({
                success: false,
                message: "Missing check-in information"
            });
        }


        const age = Number(userAge);
        const score = Number(totalScore);


        // Validate age

        if (
            !Number.isInteger(age) ||
            age < 5 ||
            age > 120
        ) {

            return res.status(400).json({
                success: false,
                message: "Age must be between 5 and 120"
            });
        }


        // Validate score

        if (
            !Number.isInteger(score) ||
            score < 0 ||
            score > 30
        ) {

            return res.status(400).json({
                success: false,
                message: "Score must be between 0 and 30"
            });
        }


        await client.query("BEGIN");


        // ===============================
        // Find existing user
        // ===============================

        const existingUser = await client.query(
            "SELECT id FROM users WHERE id = $1",
            [Number(userId)]
        );


        let savedUserId;


        // ===============================
        // Update existing user
        // ===============================

        if (existingUser.rows.length) {

            const updated = await client.query(
                `UPDATE users
                 SET name = $1,
                     age = $2,
                     updated_at = CURRENT_TIMESTAMP
                 WHERE id = $3
                 RETURNING id`,
                [
                    String(userName).trim(),
                    age,
                    Number(userId)
                ]
            );

            savedUserId = updated.rows[0].id;

        }

        // ===============================
        // Create new user
        // ===============================

        else {

            const created = await client.query(
                `INSERT INTO users (name, age)
                 VALUES ($1, $2)
                 RETURNING id`,
                [
                    String(userName).trim(),
                    age
                ]
            );

            savedUserId = created.rows[0].id;
        }


        // ===============================
        // Save Check-in
        // ===============================

        const result = await client.query(
            `INSERT INTO checkins
             (user_id, total_score, stress_level)
             VALUES ($1, $2, $3)
             RETURNING *`,
            [
                savedUserId,
                score,
                String(stressLevel)
            ]
        );


        await client.query("COMMIT");


        res.status(201).json({

            success: true,

            message: "Check-in saved successfully",

            checkin: result.rows[0]

        });


    } catch (error) {

        await client.query("ROLLBACK");

        console.error(
            "Error saving check-in:",
            error.message
        );

        res.status(500).json({

            success: false,

            message: "Failed to save check-in"

        });


    } finally {

        client.release();

    }

});


// ===============================
// GET ALL CHECK-INS FOR A USER
// ===============================

app.get("/api/checkins/:userId", async (req, res) => {

    try {

        const userId = Number(req.params.userId);


        if (!Number.isInteger(userId)) {

            return res.status(400).json({

                success: false,

                message: "Invalid user id"

            });

        }


        const result = await pool.query(

            `SELECT
                id,
                user_id,
                total_score,
                stress_level,
                created_at
             FROM checkins
             WHERE user_id = $1
             ORDER BY created_at DESC`,

            [userId]

        );


        res.json({

            success: true,

            count: result.rows.length,

            checkins: result.rows

        });


    } catch (error) {

        console.error(
            "Error fetching check-ins:",
            error.message
        );


        res.status(500).json({

            success: false,

            message: "Failed to fetch check-ins"

        });

    }

});


// ===============================
// GET ONE CHECK-IN
// ===============================

app.get("/api/checkin/:id", async (req, res) => {

    try {

        const id = Number(req.params.id);


        const result = await pool.query(

            `SELECT
                id,
                user_id,
                total_score,
                stress_level,
                created_at
             FROM checkins
             WHERE id = $1`,

            [id]

        );


        if (!result.rows.length) {

            return res.status(404).json({

                success: false,

                message: "Check-in not found"

            });

        }


        res.json({

            success: true,

            checkin: result.rows[0]

        });


    } catch (error) {

        console.error(
            "Error fetching check-in:",
            error.message
        );


        res.status(500).json({

            success: false,

            message: "Failed to fetch check-in"

        });

    }

});


// ===============================
// DELETE CHECK-IN
// ===============================

app.delete("/api/checkins/:id", async (req, res) => {

    try {

        const id = Number(req.params.id);


        const result = await pool.query(

            "DELETE FROM checkins WHERE id = $1 RETURNING *",

            [id]

        );


        if (!result.rows.length) {

            return res.status(404).json({

                success: false,

                message: "Check-in not found"

            });

        }


        res.json({

            success: true,

            message: "Check-in deleted successfully",

            checkin: result.rows[0]

        });


    } catch (error) {

        console.error(
            "Error deleting check-in:",
            error.message
        );


        res.status(500).json({

            success: false,

            message: "Failed to delete check-in"

        });

    }

});


// ===============================
// START SERVER
// ===============================

app.listen(PORT, () => {

    console.log(
     `MindPulse is running on http://localhost:${PORT}`
    );

});