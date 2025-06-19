const router = require('express').Router();
const Todo = require('../models/todoModel');

// Create
router.post('/', async (req, res) => {
  try { res.status(201).json(await Todo.create(req.body)); }
  catch (e) { res.status(400).json({ error: e.message }); }
});

// Read all
router.get('/', async (req, res) => res.json(await Todo.find()));

// Update
router.put('/:id', async (req, res) => {
  try { res.json(await Todo.findByIdAndUpdate(req.params.id, req.body, { new: true })); }
  catch (e) { res.status(400).json({ error: e.message }); }
});

// Delete
router.delete('/:id', async (req, res) => {
  try { await Todo.findByIdAndDelete(req.params.id); res.sendStatus(204); }
  catch (e) { res.status(400).json({ error: e.message }); }
});

module.exports = router;