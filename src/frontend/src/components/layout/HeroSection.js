// HeroSection component for TransGabon application

const HeroSection = () => {
  return (
    <section className="relative h-screen flex items-center justify-center overflow-hidden pt-16">
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
          <p className="text-lg sm:text-xl text-gray-300 mb-8">
            Découvrez le réseau ferroviaire gabonais avec nos trains modernes
          </p>
        </div>
        
        {/* Boutons d'action */}
        <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <button className="bg-yellow-500 hover:bg-yellow-600 text-black font-semibold px-8 py-4 rounded-lg text-lg transition-all duration-300 transform hover:scale-105 shadow-lg flex items-center gap-3">
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            Rechercher un train
          </button>
          <button className="bg-transparent border-2 border-white text-white hover:bg-white hover:text-sky-600 font-semibold px-8 py-4 rounded-lg text-lg transition-all duration-300 transform hover:scale-105 flex items-center gap-3">
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            Voir les horaires
          </button>
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
