// Footer component for TransGabon application

const Footer = () => {
  return (
    <footer className="bg-gray-900 text-white">
      {/* Section principale du footer */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-12">

          {/* Informations sur TransGabon */}
          <div className="lg:col-span-1">
            <div className="flex items-center mb-4 gap-3">
              <svg className="w-8 h-8 text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
              </svg>
              <span className="text-2xl font-bold text-yellow-400">
                TransGabon
              </span>
            </div>
            <p className="text-gray-300 mb-6 leading-relaxed text-sm">
              Le système de réservation officiel du réseau ferroviaire gabonais.
              Voyagez en toute sécurité et confort à travers le Gabon.
            </p>
            <div className="flex space-x-4 justify-start">
              <button
                type="button"
                className="text-gray-400 hover:text-yellow-400 transition-colors duration-200"
                aria-label="Suivez-nous sur Twitter"
              >
                <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"/>
                </svg>
              </button>
              <button
                type="button"
                className="text-gray-400 hover:text-yellow-400 transition-colors duration-200"
                aria-label="Suivez-nous sur Facebook"
              >
                <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M22.46 6c-.77.35-1.6.58-2.46.69.88-.53 1.56-1.37 1.88-2.38-.83.5-1.75.85-2.72 1.05C18.37 4.5 17.26 4 16 4c-2.35 0-4.27 1.92-4.27 4.29 0 .34.04.67.11.98C8.28 9.09 5.11 7.38 3 4.79c-.37.63-.58 1.37-.58 2.15 0 1.49.75 2.81 1.91 3.56-.71 0-1.37-.2-1.95-.5v.03c0 2.08 1.48 3.82 3.44 4.21a4.22 4.22 0 0 1-1.93.07 4.28 4.28 0 0 0 4 2.98 8.521 8.521 0 0 1-5.33 1.84c-.34 0-.68-.02-1.02-.06C3.44 20.29 5.7 21 8.12 21 16 21 20.33 14.46 20.33 8.79c0-.19 0-.37-.01-.56.84-.6 1.56-1.36 2.14-2.23z"/>
                </svg>
              </button>
              <button
                type="button"
                className="text-gray-400 hover:text-yellow-400 transition-colors duration-200"
                aria-label="Suivez-nous sur Instagram"
              >
                <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12.017 0C5.396 0 .029 5.367.029 11.987c0 5.079 3.158 9.417 7.618 11.174-.105-.949-.199-2.403.041-3.439.219-.937 1.406-5.957 1.406-5.957s-.359-.72-.359-1.781c0-1.663.967-2.911 2.168-2.911 1.024 0 1.518.769 1.518 1.688 0 1.029-.653 2.567-.992 3.992-.285 1.193.6 2.165 1.775 2.165 2.128 0 3.768-2.245 3.768-5.487 0-2.861-2.063-4.869-5.008-4.869-3.41 0-5.409 2.562-5.409 5.199 0 1.033.394 2.143.889 2.741.099.12.112.225.085.345-.09.375-.293 1.199-.334 1.363-.053.225-.172.271-.402.165-1.495-.69-2.433-2.878-2.433-4.646 0-3.776 2.748-7.252 7.92-7.252 4.158 0 7.392 2.967 7.392 6.923 0 4.135-2.607 7.462-6.233 7.462-1.214 0-2.357-.629-2.746-1.378l-.748 2.853c-.271 1.043-1.002 2.35-1.492 3.146C9.57 23.812 10.763 24.009 12.017 24.009c6.624 0 11.99-5.367 11.99-11.988C24.007 5.367 18.641.001 12.017.001z"/>
                </svg>
              </button>
            </div>
          </div>

          {/* Liens rapides */}
          <div>
            <h3 className="text-lg font-semibold mb-4 text-yellow-400">Liens rapides</h3>
            <ul className="space-y-2">
              <li>
                <a href="#rechercher" className="text-gray-300 hover:text-white transition-colors duration-200">
                  Rechercher un train
                </a>
              </li>
              <li>
                <a href="#horaires" className="text-gray-300 hover:text-white transition-colors duration-200">
                  Horaires et tarifs
                </a>
              </li>
              <li>
                <a href="#gares" className="text-gray-300 hover:text-white transition-colors duration-200">
                  Nos gares
                </a>
              </li>
              <li>
                <a href="#services" className="text-gray-300 hover:text-white transition-colors duration-200">
                  Services à bord
                </a>
              </li>
              <li>
                <a href="#faq" className="text-gray-300 hover:text-white transition-colors duration-200">
                  FAQ
                </a>
              </li>
            </ul>
          </div>

          {/* Contact et support */}
          <div>
            <h3 className="text-lg font-semibold mb-6 text-yellow-400">Contact & Support</h3>
            <div className="space-y-4">
              <div className="flex items-start space-x-3">
                <svg className="w-5 h-5 text-yellow-400 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"/>
                </svg>
                <div>
                  <p className="text-gray-300 text-sm">+241 01 XX XX XX</p>
                  <p className="text-gray-400 text-xs">Support téléphonique</p>
                </div>
              </div>
              <div className="flex items-start space-x-3">
                <svg className="w-5 h-5 text-yellow-400 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                  <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                </svg>
                <div>
                  <p className="text-gray-300 text-sm">contact@transgabon.ga</p>
                  <p className="text-gray-400 text-xs">Support par email</p>
                </div>
              </div>
              <div className="flex items-start space-x-3">
                <svg className="w-5 h-5 text-yellow-400 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clipRule="evenodd"/>
                </svg>
                <div>
                  <p className="text-gray-300 text-sm">Libreville, Gabon</p>
                  <p className="text-gray-400 text-xs">Siège social</p>
                </div>
              </div>
            </div>

            <div className="mt-6 pt-4 border-t border-gray-800">
              <p className="text-sm text-yellow-400 mb-2 font-medium">Heures d'ouverture</p>
              <div className="space-y-1">
                <p className="text-xs text-gray-300">Lun - Ven : 8h00 - 18h00</p>
                <p className="text-xs text-gray-300">Sam : 8h00 - 14h00</p>
                <p className="text-xs text-gray-400">Dim : Fermé</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Section du bas */}
      <div className="border-t border-gray-800 bg-gray-950">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <div className="flex flex-col lg:flex-row justify-between items-center space-y-4 lg:space-y-0">
            <div className="text-gray-400 text-sm text-center lg:text-left">
              © 2024 TransGabon. Tous droits réservés.
              <span className="block lg:inline lg:ml-2 text-xs text-gray-500">
                Système de réservation officiel du réseau ferroviaire gabonais.
              </span>
            </div>
            <div className="flex flex-wrap justify-center lg:justify-end gap-6 text-sm">
              <a href="#privacy" className="text-gray-400 hover:text-yellow-400 transition-colors duration-200">
                Politique de confidentialité
              </a>
              <a href="#terms" className="text-gray-400 hover:text-yellow-400 transition-colors duration-200">
                Conditions d'utilisation
              </a>
              <a href="#cookies" className="text-gray-400 hover:text-yellow-400 transition-colors duration-200">
                Cookies
              </a>
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
