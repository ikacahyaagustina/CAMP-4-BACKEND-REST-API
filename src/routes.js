import express from 'express';
import pool from './db.js';

const router = express.Router();

const tableConfig = {
  users: 'user_id',
  user_profiles: 'profile_id',
  destinations: 'destination_id',
  categories: 'category_id',
  destination_categories: 'id'
};

// GET ALL DATA
router.get('/:table', async (req, res) => {
  try {
    const { table } = req.params;

    if (!tableConfig[table]) {
      return res.status(400).json({ message: 'Tabel tidak valid' });
    }

    const result = await pool.query(`SELECT * FROM ${table}`);
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


// GET DATA BY ID
router.get('/:table/:id', async (req, res) => {
  try {
    const { table, id } = req.params;

    if (!tableConfig[table]) {
      return res.status(400).json({ message: 'Tabel tidak valid' });
    }

    const idField = tableConfig[table];

    const result = await pool.query(
      `SELECT * FROM ${table} WHERE ${idField} = $1`,
      [id]
    );

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


// POST
router.post('/:table', async (req, res) => {
  try {
    const { table } = req.params;
    const data = req.body;

     if (!tableConfig[table]) {
      return res.status(400).json({ message: 'Tabel tidak valid' });
    }

    const keys = Object.keys(data);
    const values = Object.values(data);

    const columns = keys.join(', ');
    const placeholders = keys.map((_, i) => `$${i + 1}`).join(', ');

    console.log('TABLE:', table);
    console.log('DATA:', data);
    console.log(`
      INSERT INTO ${table} (${columns})
      VALUES (${placeholders})
    `);

    const result = await pool.query(
      `INSERT INTO ${table} (${columns})
       VALUES (${placeholders})
       RETURNING *`,
      values
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error(error); 
    res.status(500).json({ error: error.message });
  }
});


// PUT
router.put('/:table/:id', async (req, res) => {
  try {
    const { table, id } = req.params;
    const data = req.body;

     if (!tableConfig[table]) {
      return res.status(400).json({ message: 'Tabel tidak valid' });
    }

    const keys = Object.keys(data);
    const values = Object.values(data);

    const setQuery = keys.map((key, i) => `${key} = $${i + 1}`).join(', ');
    const idField = tableConfig[table];
    
    const result = await pool.query(
      `UPDATE ${table}
       SET ${setQuery}
       WHERE ${idField} = $${keys.length + 1}
       RETURNING *`,
      [...values, id]
    );

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


// DELETE
router.delete('/:table/:id', async (req, res) => {
  try {
    const { table, id } = req.params;

    if (!tableConfig[table]) {
      return res.status(400).json({ message: 'Tabel tidak valid' });
    }

    const idField = tableConfig[table];

    const result = await pool.query(
      `DELETE FROM ${table}
       WHERE ${idField} = $1
       RETURNING *`,
      [id]
    );

    res.json({ message: 'Data berhasil dihapus', data: result.rows[0] });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;