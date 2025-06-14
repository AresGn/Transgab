import React from 'react';
import './App.css';
import Navbar from './components/layout/Navbar';
import HeroSection from './components/layout/HeroSection';
import Footer from './components/layout/Footer';

function App() {
  return (
    <div className="App min-h-screen flex flex-col">
      <Navbar />
      <main className="flex-grow pt-0">
        <HeroSection />
        {/* Contenu principal de la page sera ajouté ici */}
        <div className="container mx-auto px-4 py-8">
          <div className="bg-white rounded-lg shadow-md p-6 mb-8">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">Réseau ferroviaire gabonais</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              <div className="flex items-center space-x-3">
                <svg className="w-6 h-6 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                </svg>
                <span className="text-gray-700">22 gares du réseau Transgabonais</span>
              </div>
              <div className="flex items-center space-x-3">
                <svg className="w-6 h-6 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
                </svg>
                <span className="text-gray-700">2 types de trains : Omnibus et TSA Express</span>
              </div>
              <div className="flex items-center space-x-3">
                <svg className="w-6 h-6 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3a2 2 0 012-2h4a2 2 0 012 2v4m-6 4V7a2 2 0 012-2h4a2 2 0 012 2v4m-6 4v4a2 2 0 002 2h4a2 2 0 002-2v-4m-6 0h6" />
                </svg>
                <span className="text-gray-700">Départs : Mercredi, Jeudi et Samedi</span>
              </div>
              <div className="flex items-center space-x-3">
                <svg className="w-6 h-6 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z" />
                </svg>
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
