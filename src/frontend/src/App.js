import React from 'react';
import './App.css';
import Navbar from './components/layout/Navbar';
import HeroSection from './components/layout/HeroSection';
import Footer from './components/layout/Footer';

function App() {
  return (
    <div className="App min-h-screen flex flex-col">
      <Navbar />
      <main className="flex-grow">
        <HeroSection />
        {/* Contenu principal de la page sera ajouté ici */}
        <div className="container mx-auto px-4 py-8">
          <div className="bg-white rounded-lg shadow-md p-6 mb-8">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">Réseau ferroviaire gabonais</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              <div className="flex items-center space-x-2">
                <span className="text-2xl">🚉</span>
                <span className="text-gray-700">22 gares du réseau Transgabonais</span>
              </div>
              <div className="flex items-center space-x-2">
                <span className="text-2xl">🚂</span>
                <span className="text-gray-700">2 types de trains : Omnibus et TSA Express</span>
              </div>
              <div className="flex items-center space-x-2">
                <span className="text-2xl">📅</span>
                <span className="text-gray-700">Départs : Mercredi, Jeudi et Samedi</span>
              </div>
              <div className="flex items-center space-x-2">
                <span className="text-2xl">🎫</span>
                <span className="text-gray-700">Réservation en ligne sécurisée</span>
              </div>
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}

export default App;
