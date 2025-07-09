import React from 'react';

const App: React.FC = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-[#0f172a] to-[#1e293b] text-white">
      <header className="p-6 flex justify-between items-center bg-black bg-opacity-40 backdrop-blur">
        <h1 className="text-2xl font-bold tracking-wide">ML Toolkit</h1>
        <a
          href="/apk/mltoolkit.apk"
          download
          className="bg-yellow-400 hover:bg-yellow-300 text-black px-4 py-2 rounded-lg font-semibold transition"
        >
          Download APK
        </a>
      </header>

      <main className="text-center px-4 py-20">
        <h2 className="text-5xl font-bold mb-6">Dominate the Rift</h2>
        <p className="text-xl text-gray-300 max-w-2xl mx-auto">
          Unleash powerful visual enhancements and effects tailored for Mobile Legends. Skins, battle effects, and UI upgrades — all in one toolkit.
        </p>

        <div className="grid md:grid-cols-3 gap-6 mt-16 px-6">
          <Feature title="Hero Skins" />
          <Feature title="Battle Effects" />
          <Feature title="Upgradable Cosmetics" />
          <Feature title="Material You UI" />
          <Feature title="Safe & No Root" />
          <Feature title="Pro Tools & Guides" />
        </div>
      </main>

      <footer className="py-6 text-center text-gray-500 text-sm">
        © 2025 ML Toolkit. Not affiliated with Moonton.
      </footer>
    </div>
  );
};

const Feature: React.FC<{ title: string }> = ({ title }) => (
  <div className="bg-white/5 border border-white/10 p-6 rounded-xl hover:scale-105 transition">
    <h3 className="text-lg font-semibold">{title}</h3>
  </div>
);

export default App;
