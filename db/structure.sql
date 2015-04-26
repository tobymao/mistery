--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    play_id integer NOT NULL,
    location_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE actions_id_seq OWNED BY actions.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE answers (
    id integer NOT NULL,
    question_id integer NOT NULL,
    correct boolean DEFAULT true NOT NULL,
    location_id integer,
    text text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    suspect_id integer
);


--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    text text,
    scenario_id integer NOT NULL,
    location_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: guesses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE guesses (
    id integer NOT NULL,
    play_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_id integer,
    location_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    suspect_id integer
);


--
-- Name: guesses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guesses_id_seq OWNED BY guesses.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    name character varying NOT NULL,
    "group" character varying,
    universe_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    hidden boolean DEFAULT false NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE password_resets (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token character varying NOT NULL,
    used boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: password_resets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE password_resets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: password_resets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE password_resets_id_seq OWNED BY password_resets.id;


--
-- Name: payments_notifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payments_notifications (
    id integer NOT NULL,
    order_id integer,
    params text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_notifications_id_seq OWNED BY payments_notifications.id;


--
-- Name: payments_order_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payments_order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_order_items_id_seq OWNED BY payments_order_items.id;


--
-- Name: payments_orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payments_orders (
    id integer NOT NULL,
    user_id integer NOT NULL,
    ip_address character varying NOT NULL,
    status character varying NOT NULL,
    transaction_id character varying,
    amount integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_orders_id_seq OWNED BY payments_orders.id;


--
-- Name: payments_products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payments_products (
    id integer NOT NULL,
    purchasable_id integer NOT NULL,
    purchasable_type character varying NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_products_id_seq OWNED BY payments_products.id;


--
-- Name: payments_profiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payments_profiles (
    id integer NOT NULL,
    user_id integer NOT NULL,
    email character varying NOT NULL,
    validated boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_profiles_id_seq OWNED BY payments_profiles.id;


--
-- Name: payments_purchases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payments_purchases (
    id integer NOT NULL,
    user_id integer NOT NULL,
    purchased_id integer NOT NULL,
    purchased_type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_purchases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_purchases_id_seq OWNED BY payments_purchases.id;


--
-- Name: plays; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plays (
    id integer NOT NULL,
    active boolean DEFAULT false NOT NULL,
    points integer,
    user_id integer NOT NULL,
    scenario_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: plays_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE plays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE plays_id_seq OWNED BY plays.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE questions (
    id integer NOT NULL,
    text text NOT NULL,
    points integer NOT NULL,
    scenario_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category integer DEFAULT 1 NOT NULL
);


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: scenarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE scenarios (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text NOT NULL,
    solution text NOT NULL,
    par integer DEFAULT 0 NOT NULL,
    published boolean DEFAULT false NOT NULL,
    universe_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    plays_count integer DEFAULT 0 NOT NULL
);


--
-- Name: scenarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE scenarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scenarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE scenarios_id_seq OWNED BY scenarios.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    token character varying NOT NULL,
    ip_address character varying NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: suspects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE suspects (
    id integer NOT NULL,
    name character varying NOT NULL,
    scenario_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: suspects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE suspects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suspects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE suspects_id_seq OWNED BY suspects.id;


--
-- Name: universes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE universes (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: universes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE universes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: universes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE universes_id_seq OWNED BY universes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    login character varying,
    email character varying,
    password character varying,
    guest boolean DEFAULT false NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY actions ALTER COLUMN id SET DEFAULT nextval('actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guesses ALTER COLUMN id SET DEFAULT nextval('guesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY password_resets ALTER COLUMN id SET DEFAULT nextval('password_resets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments_notifications ALTER COLUMN id SET DEFAULT nextval('payments_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments_order_items ALTER COLUMN id SET DEFAULT nextval('payments_order_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments_orders ALTER COLUMN id SET DEFAULT nextval('payments_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments_products ALTER COLUMN id SET DEFAULT nextval('payments_products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments_profiles ALTER COLUMN id SET DEFAULT nextval('payments_profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments_purchases ALTER COLUMN id SET DEFAULT nextval('payments_purchases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY plays ALTER COLUMN id SET DEFAULT nextval('plays_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY scenarios ALTER COLUMN id SET DEFAULT nextval('scenarios_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY suspects ALTER COLUMN id SET DEFAULT nextval('suspects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY universes ALTER COLUMN id SET DEFAULT nextval('universes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: guesses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guesses
    ADD CONSTRAINT guesses_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (id);


--
-- Name: payments_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payments_notifications
    ADD CONSTRAINT payments_notifications_pkey PRIMARY KEY (id);


--
-- Name: payments_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payments_order_items
    ADD CONSTRAINT payments_order_items_pkey PRIMARY KEY (id);


--
-- Name: payments_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payments_orders
    ADD CONSTRAINT payments_orders_pkey PRIMARY KEY (id);


--
-- Name: payments_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payments_products
    ADD CONSTRAINT payments_products_pkey PRIMARY KEY (id);


--
-- Name: payments_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payments_profiles
    ADD CONSTRAINT payments_profiles_pkey PRIMARY KEY (id);


--
-- Name: payments_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payments_purchases
    ADD CONSTRAINT payments_purchases_pkey PRIMARY KEY (id);


--
-- Name: plays_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plays
    ADD CONSTRAINT plays_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: scenarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY scenarios
    ADD CONSTRAINT scenarios_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: suspects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY suspects
    ADD CONSTRAINT suspects_pkey PRIMARY KEY (id);


--
-- Name: universes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY universes
    ADD CONSTRAINT universes_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_user_id_purchased_id_purchased_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX idx_user_id_purchased_id_purchased_type ON payments_purchases USING btree (user_id, purchased_id, purchased_type);


--
-- Name: index_actions_on_play_id_and_location_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_actions_on_play_id_and_location_id ON actions USING btree (play_id, location_id);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_answers_on_question_id ON answers USING btree (question_id);


--
-- Name: index_answers_on_question_id_and_location_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_answers_on_question_id_and_location_id ON answers USING btree (question_id, location_id);


--
-- Name: index_answers_on_question_id_and_text; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_answers_on_question_id_and_text ON answers USING btree (question_id, text);


--
-- Name: index_contacts_on_scenario_id_and_location_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_contacts_on_scenario_id_and_location_id ON contacts USING btree (scenario_id, location_id);


--
-- Name: index_guesses_on_play_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guesses_on_play_id ON guesses USING btree (play_id);


--
-- Name: index_guesses_on_question_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guesses_on_question_id ON guesses USING btree (question_id);


--
-- Name: index_locations_on_universe_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_locations_on_universe_id_and_name ON locations USING btree (universe_id, lower((name)::text));


--
-- Name: index_password_resets_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_password_resets_on_user_id ON password_resets USING btree (user_id);


--
-- Name: index_payments_notifications_on_order_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_notifications_on_order_id ON payments_notifications USING btree (order_id);


--
-- Name: index_payments_order_items_on_order_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_order_items_on_order_id ON payments_order_items USING btree (order_id);


--
-- Name: index_payments_order_items_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_order_items_on_product_id ON payments_order_items USING btree (product_id);


--
-- Name: index_payments_orders_on_transaction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_orders_on_transaction_id ON payments_orders USING btree (transaction_id);


--
-- Name: index_payments_orders_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_orders_on_user_id ON payments_orders USING btree (user_id);


--
-- Name: index_payments_products_on_purchasable_type_and_purchasable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_products_on_purchasable_type_and_purchasable_id ON payments_products USING btree (purchasable_type, purchasable_id);


--
-- Name: index_payments_profiles_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_profiles_on_user_id ON payments_profiles USING btree (user_id);


--
-- Name: index_payments_purchases_on_purchased_type_and_purchased_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_purchases_on_purchased_type_and_purchased_id ON payments_purchases USING btree (purchased_type, purchased_id);


--
-- Name: index_plays_on_scenario_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plays_on_scenario_id ON plays USING btree (scenario_id);


--
-- Name: index_plays_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plays_on_user_id ON plays USING btree (user_id);


--
-- Name: index_questions_on_scenario_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_questions_on_scenario_id ON questions USING btree (scenario_id);


--
-- Name: index_scenarios_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_scenarios_on_name ON scenarios USING btree (lower((name)::text));


--
-- Name: index_scenarios_on_universe_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_scenarios_on_universe_id ON scenarios USING btree (universe_id);


--
-- Name: index_scenarios_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_scenarios_on_user_id ON scenarios USING btree (user_id);


--
-- Name: index_sessions_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_sessions_on_token ON sessions USING btree (token);


--
-- Name: index_sessions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_user_id ON sessions USING btree (user_id);


--
-- Name: index_suspects_on_scenario_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_suspects_on_scenario_id_and_name ON suspects USING btree (scenario_id, lower((name)::text));


--
-- Name: index_universes_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_universes_on_name ON universes USING btree (lower((name)::text));


--
-- Name: index_universes_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_universes_on_user_id ON universes USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (lower((email)::text));


--
-- Name: index_users_on_login; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_login ON users USING btree (lower((email)::text));


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150129051330');

INSERT INTO schema_migrations (version) VALUES ('20150129053819');

INSERT INTO schema_migrations (version) VALUES ('20150129062616');

INSERT INTO schema_migrations (version) VALUES ('20150129072616');

INSERT INTO schema_migrations (version) VALUES ('20150217052500');

INSERT INTO schema_migrations (version) VALUES ('20150218062500');

INSERT INTO schema_migrations (version) VALUES ('20150218062502');

INSERT INTO schema_migrations (version) VALUES ('20150218062503');

INSERT INTO schema_migrations (version) VALUES ('20150218062505');

INSERT INTO schema_migrations (version) VALUES ('20150218062522');

INSERT INTO schema_migrations (version) VALUES ('20150218062604');

INSERT INTO schema_migrations (version) VALUES ('20150314032122');

INSERT INTO schema_migrations (version) VALUES ('20150316060538');

INSERT INTO schema_migrations (version) VALUES ('20150317055847');

INSERT INTO schema_migrations (version) VALUES ('20150318052056');

INSERT INTO schema_migrations (version) VALUES ('20150318053400');

INSERT INTO schema_migrations (version) VALUES ('20150322073139');

INSERT INTO schema_migrations (version) VALUES ('20150322074350');

INSERT INTO schema_migrations (version) VALUES ('20150322080051');

INSERT INTO schema_migrations (version) VALUES ('20150323030628');

INSERT INTO schema_migrations (version) VALUES ('20150323031529');

INSERT INTO schema_migrations (version) VALUES ('20150324023246');

INSERT INTO schema_migrations (version) VALUES ('20150407033416');

