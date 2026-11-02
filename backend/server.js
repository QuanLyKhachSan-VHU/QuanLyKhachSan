
const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Backend Quan Ly Khach San dang hoat dong!"
  });
});

app.get("/api/test-db", async (req, res) => {
  try {
    const [rows] = await db.query("SELECT DATABASE() AS database_name");

    res.json({
      success: true,
      message: "Ket noi MySQL thanh cong!",
      database: rows[0].database_name
    });
  } catch (error) {
    console.error("Loi ket noi MySQL:", error.message);

    res.status(500).json({
      success: false,
      message: "Khong the ket noi MySQL"
    });
  }
});

app.listen(PORT, () => {
  console.log(`Server dang chay tai http://localhost:${PORT}`);
});

const db = require("./db");