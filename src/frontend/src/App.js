import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <header style={{
        backgroundColor: '#0284c7',
        color: 'white',
        padding: '2rem',
        textAlign: 'center'
      }}>
        <h1>🚂 Train Reservation Gabon</h1>
        <p>Système de réservation de tickets de train du Gabon</p>
      </header>

      <main className="container" style={{ padding: '2rem' }}>
        <div className="card">
          <h2>Bienvenue sur le système de réservation</h2>
          <p>
            Réservez vos billets de train pour voyager à travers le Gabon
            sur le réseau Transgabonais.
          </p>

          <div style={{ marginTop: '2rem' }}>
            <button className="btn-primary" style={{ marginRight: '1rem' }}>
              Rechercher un train
            </button>
            <button className="btn-outline">
              Se connecter
            </button>
          </div>
        </div>

        <div className="card" style={{ marginTop: '2rem' }}>
          <h3>Réseau ferroviaire gabonais</h3>
          <ul>
            <li>🚉 22 gares du réseau Transgabonais</li>
            <li>🚂 2 types de trains : Omnibus et TSA Express</li>
            <li>📅 Départs : Mercredi, Jeudi et Samedi</li>
            <li>🎫 Réservation en ligne sécurisée</li>
          </ul>
        </div>
      </main>
    </div>
  );
}

export default App;
