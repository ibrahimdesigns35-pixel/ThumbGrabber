import type { Config } from "tailwindcss";

const config = {
    darkMode: ["class"],
    content: [
        './pages/**/*.{ts,tsx}',
        './components/**/*.{ts,tsx}',
        './app/**/*.{ts,tsx}',
        './src/**/*.{ts,tsx}',
    ],
    theme: {
        extend: {
            fontFamily: {
                poppins: ['var(--font-poppins)', 'Poppins', 'sans-serif'],
                inter: ['var(--font-inter)', 'Inter', 'sans-serif'],
            },
            colors: {
                cyan: {
                    500: '#06b6d4',
                    400: '#22d3ee',
                },
            },
        },
    },
    plugins: [require("tailwindcss-animate")],
} satisfies Config;

export default config;
