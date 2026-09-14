-- MindPulse database setup
-- Connect to the MindPulse database before running this file.

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INTEGER NOT NULL CHECK (age BETWEEN 5 AND 120),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    age_group VARCHAR(20) NOT NULL,
    question_order INTEGER NOT NULL,
    question_text TEXT NOT NULL,
    category VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS checkins (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    total_score INTEGER NOT NULL CHECK (total_score BETWEEN 0 AND 30),
    stress_level VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (id, name, age) VALUES (1, 'Demo User', 20) ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 1, 'Have you been worried about school, homework or classwork?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=1);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 2, 'Have you found it difficult to concentrate during school?', 'focus' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=2);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 3, 'Have tests or school activities been making you nervous?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=3);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 4, 'Have you been having trouble getting enough sleep?', 'sleep' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=4);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 5, 'Have you been spending more time on screens than usual?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=5);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 6, 'Have friendship problems been bothering you?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=6);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 7, 'Have you been worried about making mistakes or disappointing others?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=7);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 8, 'Have you been feeling tired during the day?', 'sleep' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=8);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 9, 'Have you found it difficult to enjoy your usual activities?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=9);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'child', 10, 'Have things around you sometimes felt like too much to handle?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='child' AND question_order=10);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 1, 'Have schoolwork or exams been making you feel stressed?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=1);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 2, 'Have you been worrying about your future?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=2);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 3, 'Have you been comparing yourself with other people?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=3);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 4, 'Have you been feeling pressure from school or family expectations?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=4);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 5, 'Have you been finding it difficult to concentrate?', 'focus' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=5);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 6, 'Have you been having difficulty getting enough sleep?', 'sleep' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=6);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 7, 'Has social media been affecting your mood or peace of mind?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=7);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 8, 'Have you been feeling mentally tired?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=8);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 9, 'Have friendship or relationship problems been bothering you?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=9);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'teen', 10, 'Have you found it difficult to relax after a busy day?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='teen' AND question_order=10);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 1, 'Have college or work responsibilities been overwhelming?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=1);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 2, 'Have deadlines been causing you stress?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=2);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 3, 'Have you been worrying about your career or future?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=3);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 4, 'Have you been feeling pressure about financial independence?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=4);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 5, 'Have you been struggling to maintain a healthy sleep routine?', 'sleep' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=5);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 6, 'Have you been finding it difficult to concentrate?', 'focus' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=6);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 7, 'Have social expectations been affecting your peace of mind?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=7);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 8, 'Have you been feeling mentally tired even after taking breaks?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=8);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 9, 'Have you been finding it difficult to balance work, studies and personal life?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=9);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'youngAdult', 10, 'Have you been getting enough time for yourself?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='youngAdult' AND question_order=10);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 1, 'Have your work responsibilities been causing you stress?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=1);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 2, 'Have you been feeling overwhelmed by daily responsibilities?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=2);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 3, 'Have you been finding it difficult to maintain a good sleep routine?', 'sleep' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=3);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 4, 'Have financial responsibilities been worrying you?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=4);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 5, 'Have family responsibilities been affecting your peace of mind?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=5);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 6, 'Have you been finding enough time for yourself?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=6);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 7, 'Have you been feeling mentally tired during the day?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=7);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 8, 'Have you been finding it difficult to concentrate?', 'focus' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=8);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 9, 'Have you felt that there is too much to manage at once?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=9);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'adult', 10, 'Have you been finding it difficult to relax during your free time?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='adult' AND question_order=10);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 1, 'Have you been feeling worried about your daily responsibilities?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=1);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 2, 'Have you been getting enough restful sleep?', 'sleep' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=2);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 3, 'Have health or wellness concerns been occupying your thoughts?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=3);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 4, 'Have you been feeling lonely or disconnected from people around you?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=4);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 5, 'Have you been getting enough time to do things you enjoy?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=5);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 6, 'Have family responsibilities been making you feel stressed?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=6);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 7, 'Have financial or household matters been worrying you?', 'pressure' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=7);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 8, 'Have you been feeling tired during your daily activities?', 'sleep' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=8);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 9, 'Have you been finding it difficult to stay focused?', 'focus' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=9);
INSERT INTO questions (age_group, question_order, question_text, category) SELECT 'olderAdult', 10, 'Have you been feeling that you need more time to relax and recharge?', 'stress' WHERE NOT EXISTS (SELECT 1 FROM questions WHERE age_group='olderAdult' AND question_order=10);
