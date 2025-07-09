import React from 'react';

interface FeatureCardProps {
  title: string;
  description: string;
}

const FeatureCard: React.FC<FeatureCardProps> = ({ title, description }) => {
  return (
    <div className="bg-[#1e293b] border border-gray-700 p-4 rounded-xl shadow-md hover:shadow-lg transition">
      <h2 className="text-xl font-semibold mb-2">{title}</h2>
      <p className="text-gray-300">{description}</p>
    </div>
  );
};

export default FeatureCard;
