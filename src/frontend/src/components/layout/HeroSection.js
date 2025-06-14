import React from 'react';

const HeroSection = () => {
  return (
    <section className="relative h-screen flex items-center justify-center overflow-hidden">
      {/* Image de fond */}
      <div 
        className="absolute inset-0 bg-cover bg-center bg-no-repeat"
        style={{
          backgroundImage: `url('/images/hero.jpg')`,
          filter: 'brightness(0.7)'
        }}
      />
      
      {/* Overlay gradient */}
      <div className="absolute inset-0 bg-gradient-to-r from-black/60 via-black/40 to-black/60" />
      
      {/* Contenu principal */}
      <div className="relative z-10 text-center text-white px-4 sm:px-6 lg:px-8 max-w-4xl mx-auto">
        <h1 className="text-4xl sm:text-5xl lg:text-6xl font-bold mb-6 leading-tight">
          Bienvenue sur
          <span className="block text-yellow-400 mt-2">
            TransGabon
          </span>
        </h1>
        
        <p className="text-xl sm:text-2xl lg:text-3xl mb-8 text-gray-200 leading-relaxed">
          Votre système de réservation de billets de train
          <span className="block mt-2">
            pour voyager à travers le Gabon
          </span>
        </p>
        
        <div className="mb-12">
          <p className="text-lg sm:text-xl text-gray-300 mb-6">
            Découvrez le réseau ferroviaire gabonais avec nos trains modernes
          </p>
          
          {/* Statistiques rapides */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-8">
            <div className="bg-white/10 backdrop-blur-sm rounded-lg p-4">
              <div className="text-3xl font-bold text-yellow-400">22</div>
              <div className="text-sm text-gray-300">Gares desservies</div>
            </div>
            <div className="bg-white/10 backdrop-blur-sm rounded-lg p-4">
              <div className="text-3xl font-bold text-yellow-400">2</div>
              <div className="text-sm text-gray-300">Types de trains</div>
            </div>
            <div className="bg-white/10 backdrop-blur-sm rounded-lg p-4">
              <div className="text-3xl font-bold text-yellow-400">3</div>
              <div className="text-sm text-gray-300">Jours de départ</div>
            </div>
          </div>
        </div>
        
        {/* Boutons d'action */}
        <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <button className="bg-yellow-500 hover:bg-yellow-600 text-black font-semibold px-8 py-4 rounded-lg text-lg transition-all duration-300 transform hover:scale-105 shadow-lg">
            🔍 Rechercher un train
          </button>
          <button className="bg-transparent border-2 border-white text-white hover:bg-white hover:text-sky-600 font-semibold px-8 py-4 rounded-lg text-lg transition-all duration-300 transform hover:scale-105">
            📋 Voir les horaires
          </button>
        </div>
        
        {/* Informations sur les types de trains */}
        <div className="mt-12 grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="bg-white/10 backdrop-blur-sm rounded-lg p-6 text-left">
            <h3 className="text-xl font-bold mb-3 text-yellow-400">🚆 Train Omnibus</h3>
            <p className="text-gray-300 text-sm">
              Dessert toutes les 22 gares du réseau. Idéal pour les trajets locaux et régionaux.
            </p>
          </div>
          <div className="bg-white/10 backdrop-blur-sm rounded-lg p-6 text-left">
            <h3 className="text-xl font-bold mb-3 text-yellow-400">🚅 TSA Express</h3>
            <p className="text-gray-300 text-sm">
              Service rapide avec seulement 7 arrêts principaux. Parfait pour les longs trajets.
            </p>
          </div>
        </div>
      </div>
      
      {/* Indicateur de scroll */}
      <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2 animate-bounce">
        <svg 
          className="w-6 h-6 text-white" 
          fill="none" 
          stroke="currentColor" 
          viewBox="0 0 24 24"
        >
          <path 
            strokeLinecap="round" 
            strokeLinejoin="round" 
            strokeWidth={2} 
            d="M19 14l-7 7m0 0l-7-7m7 7V3" 
          />
        </svg>
      </div>
    </section>
  );
};

export default HeroSection;
