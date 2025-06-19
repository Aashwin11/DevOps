require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const path = require('path');

// Models & routes
const todoRoutes = require('./routes/todoRoutes');

const app = express();
app.use(cors());
app.use(express.json());

// Serve frontend static files from public/
app.use(express.static(path.join(__dirname, 'public')));

// Health-check endpoint
app.get('/health', (req, res) => res.json({ status: 'OK', uptime: process.uptime() }));

// API routes
app.use('/todos', todoRoutes);

// (Optional) Fallback to index.html for client-side routing — temporarily disabled due to path-to-regexp issue
// app.get('/*', (req, res) => {
//   res.sendFile(path.join(__dirname, 'public', 'index.html'));
// });

// Connect to MongoDB & start server
mongoose.connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
  })
  .then(() => {
    console.log('MongoDB connected');
    app.listen(process.env.PORT, () => {
      console.log(`Server running on port ${process.env.PORT}`);
    });
  })
  .catch(err => console.error('DB error:', err));