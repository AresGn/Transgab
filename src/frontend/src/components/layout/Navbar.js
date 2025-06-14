import { useState } from 'react';

const Navbar = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };

  return (
    <nav className="bg-sky-600 shadow-lg fixed top-0 left-0 right-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          {/* Logo et titre */}
          <div className="flex items-center">
            <div className="flex-shrink-0 flex items-center gap-3">
              <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
              </svg>
              <span className="text-white text-2xl font-bold">
                TransGabon
              </span>
            </div>
          </div>

          {/* Navigation desktop */}
          <div className="hidden md:block">
            <div className="ml-10 flex items-baseline space-x-4">
              <a
                href="#accueil"
                className="text-white hover:bg-sky-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium transition-colors duration-200"
              >
                Accueil
              </a>
              <a
                href="#rechercher"
                className="text-sky-100 hover:bg-sky-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium transition-colors duration-200"
              >
                Rechercher
              </a>
              <a
                href="#reservations"
                className="text-sky-100 hover:bg-sky-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium transition-colors duration-200"
              >
              Réservations
              </a>
              <a
                href="#apropos"
                className="text-sky-100 hover:bg-sky-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium transition-colors duration-200"
              >
                À propos
              </a>
            </div>
          </div>

          {/* Bouton de connexion desktop */}
          <div className="hidden md:block">
            <button className="bg-white text-sky-600 hover:bg-sky-50 px-4 py-2 rounded-md text-sm font-medium transition-colors duration-200 border border-white">
              Se connecter
            </button>
          </div>

          {/* Bouton menu mobile */}
          <div className="md:hidden">
            <button
              onClick={toggleMenu}
              className="text-white hover:text-sky-200 focus:outline-none focus:text-sky-200 p-2"
              aria-label="Menu principal"
            >
              <svg
                className="h-6 w-6"
                stroke="currentColor"
                fill="none"
                viewBox="0 0 24 24"
              >
                {isMenuOpen ? (
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="2"
                    d="M6 18L18 6M6 6l12 12"
                  />
                ) : (
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="2"
                    d="M4 6h16M4 12h16M4 18h16"
                  />
                )}
              </svg>
            </button>
          </div>
        </div>
      </div>

      {/* Menu mobile */}
      {isMenuOpen && (
        <div className="md:hidden">
          <div className="px-2 pt-2 pb-3 space-y-1 sm:px-3 bg-sky-700">
            <a
              href="#accueil"
              className="text-white hover:bg-sky-800 block px-3 py-2 rounded-md text-base font-medium transition-colors duration-200"
              onClick={() => setIsMenuOpen(false)}
            >
              Accueil
            </a>
            <a
              href="#rechercher"
              className="text-sky-100 hover:bg-sky-800 hover:text-white block px-3 py-2 rounded-md text-base font-medium transition-colors duration-200"
              onClick={() => setIsMenuOpen(false)}
            >
              Rechercher
            </a>
            <a
              href="#reservations"
              className="text-sky-100 hover:bg-sky-800 hover:text-white block px-3 py-2 rounded-md text-base font-medium transition-colors duration-200"
              onClick={() => setIsMenuOpen(false)}
            >
              Réservations
            </a>
            <a
              href="#apropos"
              className="text-sky-100 hover:bg-sky-800 hover:text-white block px-3 py-2 rounded-md text-base font-medium transition-colors duration-200"
              onClick={() => setIsMenuOpen(false)}
            >
              À propos
            </a>
            <div className="pt-2">
              <button className="w-full bg-white text-sky-600 hover:bg-sky-50 px-4 py-2 rounded-md text-base font-medium transition-colors duration-200 border border-white">
                Se connecter
              </button>
            </div>
          </div>
        </div>
      )}
    </nav>
  );
};

export default Navbar;
