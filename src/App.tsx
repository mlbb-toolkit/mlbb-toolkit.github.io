import React from 'react';
import FeatureCard from './components/FeatureCard';
import logo from './assets/play_store_512.png';

const App: React.FC = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-[#0f172a] to-[#1e293b] text-white">
      <header className="p-6 flex justify-between items-center">
        <img src={logo} alt="ML Toolkit Logo" className="h-12" />
        <a
          href="/apk/mltoolkit.apk"
          download
          className="bg-white text-black font-semibold px-4 py-2 rounded-lg hover:bg-gray-200 transition"
        >
          Download APK
        </a>
      </header>

      <main className="text-center px-4 py-10">
        <h1 className="text-4xl font-bold mb-4">ML Toolkit</h1>
        <p className="text-lg text-gray-300 max-w-xl mx-auto mb-8">
          Enhance your Mobile Legends experience with customizable skins, effects, and pro tools—without compromising safety or performance.
        </p>

        <section className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6 px-4 mt-8">
          <FeatureCard title="Inject Skins" description="Unlock a wide selection of hero and custom skins." />
          <FeatureCard title="Battle Effects" description="Modify emotes, recalls, and elimination effects." />
          <FeatureCard title="Safe & Smooth" description="No root needed. Built for performance." />
          <FeatureCard title="Material You UI" description="Clean and modern interface experience." />
          <FeatureCard title="Hero Guides" description="Learn combos, counters, compatibility and more." />
          <FeatureCard title="Upgradable Skins" description="Unlock epic versions of your favorite skins." />
        </section>
      </main>

      <footer className="text-center text-gray-400 py-6">
        © 2025 ML Toolkit. Not affiliated with Moonton.
      </footer>
    </div>
  );
};

export default App;
