--
-- PostgreSQL database dump
--

\restrict 99yQhco3UeBvJO5h4cPSwxZrFK6crGYvmRdMoE5fygx0kQriwOdtaYL8zpgUNTX

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-04-18 13:25:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 49818)
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    master_id integer NOT NULL,
    service_id integer NOT NULL,
    appointment_date timestamp without time zone NOT NULL,
    queue_number integer,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 49817)
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_id_seq OWNER TO postgres;

--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 231
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- TOC entry 240 (class 1259 OID 49916)
-- Name: balance_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.balance_transactions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    description text
);


ALTER TABLE public.balance_transactions OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 49915)
-- Name: balance_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.balance_transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.balance_transactions_id_seq OWNER TO postgres;

--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 239
-- Name: balance_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.balance_transactions_id_seq OWNED BY public.balance_transactions.id;


--
-- TOC entry 226 (class 1259 OID 49768)
-- Name: collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collections (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.collections OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 49767)
-- Name: collections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collections_id_seq OWNER TO postgres;

--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 225
-- Name: collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collections_id_seq OWNED BY public.collections.id;


--
-- TOC entry 234 (class 1259 OID 49847)
-- Name: master_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.master_reviews (
    id integer NOT NULL,
    user_id integer NOT NULL,
    master_id integer NOT NULL,
    rating integer,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT master_reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.master_reviews OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 49846)
-- Name: master_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.master_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.master_reviews_id_seq OWNER TO postgres;

--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 233
-- Name: master_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.master_reviews_id_seq OWNED BY public.master_reviews.id;


--
-- TOC entry 230 (class 1259 OID 49798)
-- Name: master_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.master_services (
    id integer NOT NULL,
    master_id integer NOT NULL,
    service_id integer NOT NULL
);


ALTER TABLE public.master_services OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 49797)
-- Name: master_services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.master_services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.master_services_id_seq OWNER TO postgres;

--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 229
-- Name: master_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.master_services_id_seq OWNED BY public.master_services.id;


--
-- TOC entry 224 (class 1259 OID 49750)
-- Name: masters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.masters (
    id integer NOT NULL,
    user_id integer NOT NULL,
    qualification integer DEFAULT 1,
    hire_date date DEFAULT CURRENT_DATE
);


ALTER TABLE public.masters OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 49749)
-- Name: masters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.masters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.masters_id_seq OWNER TO postgres;

--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 223
-- Name: masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.masters_id_seq OWNED BY public.masters.id;


--
-- TOC entry 238 (class 1259 OID 49895)
-- Name: qualification_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qualification_requests (
    id integer NOT NULL,
    master_id integer NOT NULL,
    request_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'pending'::character varying,
    processed_by_moderator_id integer
);


ALTER TABLE public.qualification_requests OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 49894)
-- Name: qualification_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qualification_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.qualification_requests_id_seq OWNER TO postgres;

--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 237
-- Name: qualification_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qualification_requests_id_seq OWNED BY public.qualification_requests.id;


--
-- TOC entry 220 (class 1259 OID 49717)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 49716)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 236 (class 1259 OID 49871)
-- Name: service_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_reviews (
    id integer NOT NULL,
    user_id integer NOT NULL,
    service_id integer NOT NULL,
    rating integer,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT service_reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.service_reviews OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 49870)
-- Name: service_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_reviews_id_seq OWNER TO postgres;

--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 235
-- Name: service_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_reviews_id_seq OWNED BY public.service_reviews.id;


--
-- TOC entry 228 (class 1259 OID 49779)
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    collection_id integer,
    last_modified_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.services OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 49778)
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO postgres;

--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 227
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- TOC entry 222 (class 1259 OID 49728)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    full_name character varying(200) NOT NULL,
    role_id integer NOT NULL,
    balance numeric(10,2) DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 49727)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4919 (class 2604 OID 49821)
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- TOC entry 4929 (class 2604 OID 49919)
-- Name: balance_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance_transactions ALTER COLUMN id SET DEFAULT nextval('public.balance_transactions_id_seq'::regclass);


--
-- TOC entry 4914 (class 2604 OID 49771)
-- Name: collections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections ALTER COLUMN id SET DEFAULT nextval('public.collections_id_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 49850)
-- Name: master_reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_reviews ALTER COLUMN id SET DEFAULT nextval('public.master_reviews_id_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 49801)
-- Name: master_services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_services ALTER COLUMN id SET DEFAULT nextval('public.master_services_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 49753)
-- Name: masters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masters ALTER COLUMN id SET DEFAULT nextval('public.masters_id_seq'::regclass);


--
-- TOC entry 4926 (class 2604 OID 49898)
-- Name: qualification_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualification_requests ALTER COLUMN id SET DEFAULT nextval('public.qualification_requests_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 49720)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4924 (class 2604 OID 49874)
-- Name: service_reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_reviews ALTER COLUMN id SET DEFAULT nextval('public.service_reviews_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 49782)
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 49731)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5138 (class 0 OID 49818)
-- Dependencies: 232
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (1, 1, 1, 1, '2025-05-10 10:00:00', 1, 'active', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (2, 2, 1, 2, '2025-05-10 12:00:00', 2, 'active', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (3, 3, 1, 3, '2025-05-11 14:00:00', 1, 'active', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (4, 4, 2, 6, '2025-05-12 11:00:00', 1, 'active', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (5, 5, 2, 7, '2025-05-12 15:30:00', 2, 'active', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (6, 1, 2, 8, '2025-05-13 09:00:00', 1, 'active', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (7, 2, 1, 4, '2025-05-13 16:00:00', 3, 'cancelled', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (8, 3, 1, 5, '2025-05-14 13:00:00', 1, 'active', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (9, 4, 2, 9, '2025-05-15 10:30:00', 1, 'active', '2026-04-17 13:36:38.306207');
INSERT INTO public.appointments (id, user_id, master_id, service_id, appointment_date, queue_number, status, created_at) VALUES (10, 5, 2, 10, '2025-05-16 12:00:00', 2, 'active', '2026-04-17 13:36:38.306207');


--
-- TOC entry 5146 (class 0 OID 49916)
-- Dependencies: 240
-- Data for Name: balance_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (1, 1, 1000.00, '2026-04-17 13:36:38.306207', 'Пополнение с карты');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (2, 2, 500.00, '2026-04-17 13:36:38.306207', 'Пополнение с карты');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (3, 3, 2000.00, '2026-04-17 13:36:38.306207', 'Пополнение с карты');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (4, 4, 3000.00, '2026-04-17 13:36:38.306207', 'Пополнение с карты');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (5, 5, 700.00, '2026-04-17 13:36:38.306207', 'Пополнение с карты');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (6, 1, 1500.00, '2026-04-17 13:36:38.306207', 'Бонус от лавки');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (7, 2, 300.00, '2026-04-17 13:36:38.306207', 'Кэшбэк');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (8, 3, 5000.00, '2026-04-17 13:36:38.306207', 'Пополнение с карты');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (9, 4, 800.00, '2026-04-17 13:36:38.306207', 'Пополнение с карты');
INSERT INTO public.balance_transactions (id, user_id, amount, transaction_date, description) VALUES (10, 5, 1200.00, '2026-04-17 13:36:38.306207', 'Подарок');


--
-- TOC entry 5132 (class 0 OID 49768)
-- Dependencies: 226
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.collections (id, name) VALUES (1, 'Аниме');
INSERT INTO public.collections (id, name) VALUES (2, 'Новый год');
INSERT INTO public.collections (id, name) VALUES (3, 'Хэллоуин');
INSERT INTO public.collections (id, name) VALUES (4, 'Киберпанк');
INSERT INTO public.collections (id, name) VALUES (5, 'Нуар');
INSERT INTO public.collections (id, name) VALUES (6, 'Фэнтези');
INSERT INTO public.collections (id, name) VALUES (7, 'Стимпанк');
INSERT INTO public.collections (id, name) VALUES (8, 'Ретро');
INSERT INTO public.collections (id, name) VALUES (9, 'Космос');
INSERT INTO public.collections (id, name) VALUES (10, 'Сказки');


--
-- TOC entry 5140 (class 0 OID 49847)
-- Dependencies: 234
-- Data for Name: master_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (1, 1, 1, 5, 'Великолепный мастер, очень довольна!', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (2, 2, 1, 4, 'Хорошо, но дороговато', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (3, 3, 1, 5, 'Лучший в городе', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (4, 4, 2, 3, 'Нормально, но опаздывает', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (5, 5, 2, 4, 'Креативный подход', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (6, 1, 2, 5, 'Сделал невероятный костюм', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (7, 2, 1, 4, 'Всё понравилось', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (8, 3, 2, 5, 'Быстро и качественно', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (9, 4, 1, 5, 'Обязательно приду ещё', '2026-04-17 13:36:38.306207');
INSERT INTO public.master_reviews (id, user_id, master_id, rating, comment, created_at) VALUES (10, 5, 1, 4, 'Хороший специалист', '2026-04-17 13:36:38.306207');


--
-- TOC entry 5136 (class 0 OID 49798)
-- Dependencies: 230
-- Data for Name: master_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.master_services (id, master_id, service_id) VALUES (1, 1, 1);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (2, 1, 2);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (3, 1, 3);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (4, 1, 4);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (5, 1, 5);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (6, 2, 6);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (7, 2, 7);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (8, 2, 8);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (9, 2, 9);
INSERT INTO public.master_services (id, master_id, service_id) VALUES (10, 2, 10);


--
-- TOC entry 5130 (class 0 OID 49750)
-- Dependencies: 224
-- Data for Name: masters; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.masters (id, user_id, qualification, hire_date) VALUES (1, 9, 3, '2026-04-17');
INSERT INTO public.masters (id, user_id, qualification, hire_date) VALUES (2, 10, 1, '2026-04-17');


--
-- TOC entry 5144 (class 0 OID 49895)
-- Dependencies: 238
-- Data for Name: qualification_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (1, 1, '2026-04-17 13:36:38.306207', 'pending', NULL);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (2, 1, '2026-04-17 13:36:38.306207', 'approved', 6);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (3, 1, '2026-04-17 13:36:38.306207', 'rejected', 7);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (4, 2, '2026-04-17 13:36:38.306207', 'pending', NULL);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (5, 2, '2026-04-17 13:36:38.306207', 'approved', 6);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (6, 1, '2026-04-17 13:36:38.306207', 'pending', NULL);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (7, 2, '2026-04-17 13:36:38.306207', 'pending', NULL);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (8, 1, '2026-04-17 13:36:38.306207', 'approved', 7);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (9, 2, '2026-04-17 13:36:38.306207', 'rejected', 6);
INSERT INTO public.qualification_requests (id, master_id, request_date, status, processed_by_moderator_id) VALUES (10, 1, '2026-04-17 13:36:38.306207', 'pending', NULL);


--
-- TOC entry 5126 (class 0 OID 49717)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles (id, name) VALUES (1, 'client');
INSERT INTO public.roles (id, name) VALUES (2, 'moderator');
INSERT INTO public.roles (id, name) VALUES (3, 'admin');
INSERT INTO public.roles (id, name) VALUES (4, 'master');


--
-- TOC entry 5142 (class 0 OID 49871)
-- Dependencies: 236
-- Data for Name: service_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (1, 1, 1, 5, 'Костюм просто сказка!', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (2, 2, 2, 4, 'Макияж держался всю ночь', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (3, 3, 3, 5, 'Очень реалистично', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (4, 4, 4, 5, 'Светодиоды работают отлично', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (5, 5, 5, 4, 'Стильный костюм', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (6, 1, 6, 5, 'Уши как живые', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (7, 2, 7, 3, 'Тяжеловаты', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (8, 3, 8, 5, 'Причёска шикарная', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (9, 4, 9, 4, 'Очень удобный скафандр', '2026-04-17 13:36:38.306207');
INSERT INTO public.service_reviews (id, user_id, service_id, rating, comment, created_at) VALUES (10, 5, 10, 5, 'Баба-Яга – огонь!', '2026-04-17 13:36:38.306207');


--
-- TOC entry 5134 (class 0 OID 49779)
-- Dependencies: 228
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (1, 'Косплей-костюм Наруто', 'Полный образ', 5000.00, 1, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (2, 'Новогодний макияж', 'С блёстками', 2500.00, 2, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (3, 'Образ Хэллоуин', 'Кровь и спецэффекты', 3000.00, 3, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (4, 'Кибер-рука', 'Светодиоды', 7000.00, 4, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (5, 'Детективный костюм', 'В стиле нуар', 4000.00, 5, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (6, 'Эльфийские уши', 'Кастомные', 1500.00, 6, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (7, 'Паровой горелки', 'Аксессуар', 2200.00, 7, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (8, 'Прическа 20-х', 'Волны', 1800.00, 8, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (9, 'Скафандр', 'Для косплея', 9000.00, 9, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.services (id, name, description, price, collection_id, last_modified_date, created_at) VALUES (10, 'Костюм Бабы-Яги', 'Сказочный', 3500.00, 10, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');


--
-- TOC entry 5128 (class 0 OID 49728)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (1, 'client1', 'pass1', 'Анна Иванова', 1, 1200.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (2, 'client2', 'pass2', 'Петр Петров', 1, 500.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (3, 'client3', 'pass3', 'Мария Сидорова', 1, 0.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (4, 'client4', 'pass4', 'Иван Козлов', 1, 8000.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (5, 'client5', 'pass5', 'Елена Морозова', 1, 300.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (6, 'moder1', 'modpass', 'Светлана Модератор', 2, 0.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (7, 'moder2', 'modpass2', 'Дмитрий Модератор', 2, 0.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (8, 'admin1', 'adminpass', 'Олег Администратор', 3, 0.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (9, 'master1', 'masterpass', 'Мария Мастер', 4, 0.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');
INSERT INTO public.users (id, login, password, full_name, role_id, balance, created_at, updated_at) VALUES (10, 'master2', 'masterpass2', 'Алексей Мастер', 4, 0.00, '2026-04-17 13:36:38.306207', '2026-04-17 13:36:38.306207');


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 231
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_id_seq', 10, true);


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 239
-- Name: balance_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.balance_transactions_id_seq', 10, true);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 225
-- Name: collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collections_id_seq', 10, true);


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 233
-- Name: master_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.master_reviews_id_seq', 10, true);


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 229
-- Name: master_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.master_services_id_seq', 10, true);


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 223
-- Name: masters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.masters_id_seq', 2, true);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 237
-- Name: qualification_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qualification_requests_id_seq', 10, true);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 4, true);


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 235
-- Name: service_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_reviews_id_seq', 10, true);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 227
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 11, true);


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- TOC entry 4954 (class 2606 OID 49830)
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- TOC entry 4962 (class 2606 OID 49927)
-- Name: balance_transactions balance_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance_transactions
    ADD CONSTRAINT balance_transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 4946 (class 2606 OID 49777)
-- Name: collections collections_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_name_key UNIQUE (name);


--
-- TOC entry 4948 (class 2606 OID 49775)
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- TOC entry 4956 (class 2606 OID 49859)
-- Name: master_reviews master_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_reviews
    ADD CONSTRAINT master_reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 4952 (class 2606 OID 49806)
-- Name: master_services master_services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_services
    ADD CONSTRAINT master_services_pkey PRIMARY KEY (id);


--
-- TOC entry 4942 (class 2606 OID 49759)
-- Name: masters masters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masters
    ADD CONSTRAINT masters_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 49761)
-- Name: masters masters_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masters
    ADD CONSTRAINT masters_user_id_key UNIQUE (user_id);


--
-- TOC entry 4960 (class 2606 OID 49904)
-- Name: qualification_requests qualification_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualification_requests
    ADD CONSTRAINT qualification_requests_pkey PRIMARY KEY (id);


--
-- TOC entry 4934 (class 2606 OID 49726)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4936 (class 2606 OID 49724)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4958 (class 2606 OID 49883)
-- Name: service_reviews service_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_reviews
    ADD CONSTRAINT service_reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 4950 (class 2606 OID 49791)
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- TOC entry 4938 (class 2606 OID 49743)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 4940 (class 2606 OID 49741)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4968 (class 2606 OID 49836)
-- Name: appointments appointments_master_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_master_id_fkey FOREIGN KEY (master_id) REFERENCES public.masters(id) ON DELETE CASCADE;


--
-- TOC entry 4969 (class 2606 OID 49841)
-- Name: appointments appointments_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- TOC entry 4970 (class 2606 OID 49831)
-- Name: appointments appointments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4977 (class 2606 OID 49928)
-- Name: balance_transactions balance_transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.balance_transactions
    ADD CONSTRAINT balance_transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4971 (class 2606 OID 49865)
-- Name: master_reviews master_reviews_master_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_reviews
    ADD CONSTRAINT master_reviews_master_id_fkey FOREIGN KEY (master_id) REFERENCES public.masters(id) ON DELETE CASCADE;


--
-- TOC entry 4972 (class 2606 OID 49860)
-- Name: master_reviews master_reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_reviews
    ADD CONSTRAINT master_reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4966 (class 2606 OID 49807)
-- Name: master_services master_services_master_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_services
    ADD CONSTRAINT master_services_master_id_fkey FOREIGN KEY (master_id) REFERENCES public.masters(id) ON DELETE CASCADE;


--
-- TOC entry 4967 (class 2606 OID 49812)
-- Name: master_services master_services_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_services
    ADD CONSTRAINT master_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- TOC entry 4964 (class 2606 OID 49762)
-- Name: masters masters_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masters
    ADD CONSTRAINT masters_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4975 (class 2606 OID 49905)
-- Name: qualification_requests qualification_requests_master_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualification_requests
    ADD CONSTRAINT qualification_requests_master_id_fkey FOREIGN KEY (master_id) REFERENCES public.masters(id) ON DELETE CASCADE;


--
-- TOC entry 4976 (class 2606 OID 49910)
-- Name: qualification_requests qualification_requests_processed_by_moderator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualification_requests
    ADD CONSTRAINT qualification_requests_processed_by_moderator_id_fkey FOREIGN KEY (processed_by_moderator_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 4973 (class 2606 OID 49889)
-- Name: service_reviews service_reviews_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_reviews
    ADD CONSTRAINT service_reviews_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- TOC entry 4974 (class 2606 OID 49884)
-- Name: service_reviews service_reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_reviews
    ADD CONSTRAINT service_reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4965 (class 2606 OID 49792)
-- Name: services services_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections(id) ON DELETE SET NULL;


--
-- TOC entry 4963 (class 2606 OID 49744)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE RESTRICT;


-- Completed on 2026-04-18 13:25:48

--
-- PostgreSQL database dump complete
--

\unrestrict 99yQhco3UeBvJO5h4cPSwxZrFK6crGYvmRdMoE5fygx0kQriwOdtaYL8zpgUNTX

