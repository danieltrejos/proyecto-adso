--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2025-06-12 17:23:02

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16527)
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    price double precision NOT NULL,
    image text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    stock integer NOT NULL,
    type text
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16526)
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Product_id_seq" OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 216
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- TOC entry 215 (class 1259 OID 16517)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16928)
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id text NOT NULL,
    name text NOT NULL,
    registration_number text NOT NULL,
    email text NOT NULL,
    phone text,
    currency text DEFAULT 'USD'::text NOT NULL,
    timezone text DEFAULT 'America/Bogota'::text NOT NULL,
    logo text,
    street text NOT NULL,
    city text NOT NULL,
    region_province text NOT NULL,
    postal_code text NOT NULL,
    country text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17514)
-- Name: currencies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currencies (
    id integer NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    symbol text NOT NULL,
    "precision" integer DEFAULT 2 NOT NULL,
    "thousandSeparator" text DEFAULT ','::text NOT NULL,
    "decimalSeparator" text DEFAULT '.'::text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.currencies OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17513)
-- Name: currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.currencies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.currencies_id_seq OWNER TO postgres;

--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 227
-- Name: currencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.currencies_id_seq OWNED BY public.currencies.id;


--
-- TOC entry 221 (class 1259 OID 16596)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name text NOT NULL,
    email text,
    phone text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    address text
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16595)
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 220
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 225 (class 1259 OID 16617)
-- Name: sale_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale_items (
    id integer NOT NULL,
    quantity integer NOT NULL,
    price double precision NOT NULL,
    "saleId" integer NOT NULL,
    "productId" integer NOT NULL
);


ALTER TABLE public.sale_items OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16616)
-- Name: sale_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sale_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sale_items_id_seq OWNER TO postgres;

--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 224
-- Name: sale_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sale_items_id_seq OWNED BY public.sale_items.id;


--
-- TOC entry 223 (class 1259 OID 16606)
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    id integer NOT NULL,
    total double precision NOT NULL,
    "paymentAmount" double precision NOT NULL,
    change double precision NOT NULL,
    "paymentMethod" text DEFAULT 'Cash'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" integer NOT NULL,
    "customerId" integer,
    "companyId" text NOT NULL,
    "invoiceNumber" text,
    subtotal double precision NOT NULL,
    "taxAmount" double precision NOT NULL,
    "taxRate" double precision NOT NULL
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16605)
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sales_id_seq OWNER TO postgres;

--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 222
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- TOC entry 230 (class 1259 OID 17528)
-- Name: taxes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxes (
    id integer NOT NULL,
    name text NOT NULL,
    rate double precision NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "isDefault" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.taxes OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17527)
-- Name: taxes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taxes_id_seq OWNER TO postgres;

--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 229
-- Name: taxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxes_id_seq OWNED BY public.taxes.id;


--
-- TOC entry 219 (class 1259 OID 16586)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    role text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16585)
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
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4728 (class 2604 OID 16530)
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- TOC entry 4741 (class 2604 OID 17517)
-- Name: currencies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies ALTER COLUMN id SET DEFAULT nextval('public.currencies_id_seq'::regclass);


--
-- TOC entry 4732 (class 2604 OID 16599)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 4737 (class 2604 OID 16620)
-- Name: sale_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items ALTER COLUMN id SET DEFAULT nextval('public.sale_items_id_seq'::regclass);


--
-- TOC entry 4734 (class 2604 OID 16609)
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- TOC entry 4747 (class 2604 OID 17531)
-- Name: taxes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxes ALTER COLUMN id SET DEFAULT nextval('public.taxes_id_seq'::regclass);


--
-- TOC entry 4730 (class 2604 OID 16589)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4924 (class 0 OID 16527)
-- Dependencies: 217
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES (4, 'Club colombia ', 'Cervezas club colombia 330ml ', 4000, NULL, '2025-04-20 18:45:49.469', '2025-06-05 21:44:21.284', 141, 'Cerveza');
INSERT INTO public."Product" VALUES (8, 'Costeñita', 'Cerveza de 175 ml.', 3000, 'https://www.bavaria.co/sites/g/files/seuoyk1666/files/2023-10/BOTELLA_COSTENITA_0.png', '2025-06-03 02:06:15.545', '2025-06-05 21:44:21.285', 115, 'Lager');
INSERT INTO public."Product" VALUES (1, 'Malta', 'Gaseosa', 300, NULL, '2025-04-20 19:56:23.724', '2025-06-03 14:57:42.411', 448, 'Gaseosa');
INSERT INTO public."Product" VALUES (5, 'Aguila Light', 'Cerveza la Aguila Light 330ml', 3000, 'https://jotajotafoods.com/wp-content/uploads/2022/06/CER00037.jpg', '2025-04-20 19:34:50.599', '2025-06-03 23:27:44.554', 221, 'Lager');
INSERT INTO public."Product" VALUES (7, 'Aguila', 'Cerveza colombiana', 4000, 'https://www.clubcolombia.com.co/sites/g/files/seuoyk481/files/2023-05/InternaRoja.png.webp', '2025-04-19 20:01:30.853', '2025-06-03 23:28:36.586', 234, 'Lager');
INSERT INTO public."Product" VALUES (10, 'Redd''s', 'Cerveza con sabor a manzana, refrescante y ligera.', 4500, 'https://example.com/redds.jpg', '2025-06-03 14:07:50.184', '2025-06-04 02:07:04.871', 180, 'Fruit Beer');
INSERT INTO public."Product" VALUES (3, 'Duvel', 'Cerveza Roja', 5500, 'https://www.clubcolombia.com.co/sites/g/files/seuoyk481/files/2023-05/InternaRoja.png.webp', '2025-04-19 20:03:56.947', '2025-06-05 02:23:20.494', 108, 'Lager');
INSERT INTO public."Product" VALUES (12, 'Apóstol Bock', 'Bock con cuerpo robusto y sabor maltoso intenso.', 8500, 'https://example.com/apostol-bock.jpg', '2025-06-03 14:22:52.562', '2025-06-05 02:23:20.498', 99, 'Bock');
INSERT INTO public."Product" VALUES (2, 'Costeña', 'Costena 330ml', 4000, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlBxST3savqc834LXLqzKBYkjHiRMA2vu8jQ&s', '2025-04-20 17:30:23', '2025-06-05 15:04:48.921', 190, 'Lager');
INSERT INTO public."Product" VALUES (6, 'Heineken', 'Cerveza lager', 4500, 'heineken.com', '2025-05-21 00:36:06.229', '2025-06-05 15:04:48.922', 208, 'Lager');
INSERT INTO public."Product" VALUES (9, 'Poker', 'Cerveza tipo lager de sabor suave.', 3500, 'https://example.com/poker.jpg', '2025-06-03 14:04:34.217', '2025-06-05 15:04:48.923', 39, 'Lager');
INSERT INTO public."Product" VALUES (11, 'Andina', 'Lager colombiana con notas suaves, perfecta para climas cálidos.', 4000, 'https://example.com/andina.jpg', '2025-06-03 14:09:08.092', '2025-06-05 21:44:21.281', 138, 'Lager');


--
-- TOC entry 4922 (class 0 OID 16517)
-- Dependencies: 215
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public._prisma_migrations VALUES ('d7129d05-f687-4a21-8ad9-0e8b13c364e3', '90a6ca54ef2dcb3e2dd5aa30abc171d72835a9457a8a88ca15106208dece09fb', '2025-05-30 09:06:59.410138-05', '20250419143237_init', NULL, NULL, '2025-05-30 09:06:59.399015-05', 1);
INSERT INTO public._prisma_migrations VALUES ('07c3ee01-8b7a-4ce2-a64d-8dd96795e316', '553a08639f2f44e5bdcd5b6beca37fd9b74d753e8f85d0c9faca30ecd3aad0c4', '2025-05-30 09:06:59.412612-05', '20250419152118_stock_added', NULL, NULL, '2025-05-30 09:06:59.410515-05', 1);
INSERT INTO public._prisma_migrations VALUES ('6e5f0607-0c8a-43e3-9c5e-ecef932debbb', '4a1c438f0af05032d66f138e8333f4184e437ce5392701750ca275fff732beeb', '2025-05-30 09:06:59.415678-05', '20250419155426_product_name_require', NULL, NULL, '2025-05-30 09:06:59.412963-05', 1);
INSERT INTO public._prisma_migrations VALUES ('37188a7c-0a97-48e3-ad98-82355b17f31d', '65b09b229ed3f92818784af442e373855fe44ca7905bde7f64d5b3a0eee762e3', '2025-05-30 09:06:59.417979-05', '20250420163341_add_product_type', NULL, NULL, '2025-05-30 09:06:59.416195-05', 1);
INSERT INTO public._prisma_migrations VALUES ('9df2b27d-26ec-43ef-92e6-93332c6b9a4b', 'f8e950379afa5be27d7563e41951292618d9b180e411765b5e32490c8dd45d9c', '2025-05-30 09:57:52.822608-05', '20250530145752_add_sales_users_models', NULL, NULL, '2025-05-30 09:57:52.793284-05', 1);
INSERT INTO public._prisma_migrations VALUES ('9c97b080-6609-4897-ad79-8aa04a2e1c10', 'cb27e2ed0b7c315ffb0fd37bcb1b062bf06f8560bc1b9ad1e99bcb8b7c3c12e7', '2025-06-11 17:03:52.739059-05', '20250611220351_add_company_model', NULL, NULL, '2025-06-11 17:03:52.704572-05', 1);
INSERT INTO public._prisma_migrations VALUES ('8302bff3-7a09-4c76-8595-bb7b858802fa', '86e29cffd4fbc419f5496ce63a24e090b76bcb1383970c6b60d9fdf214b3f7fc', '2025-06-12 16:58:12.791888-05', '20250612215811_add_invoice_fields_optional', NULL, NULL, '2025-06-12 16:58:12.719469-05', 1);
INSERT INTO public._prisma_migrations VALUES ('ef1c09a6-8374-4887-b5cf-a6deefae1b5c', '7ab9e3c9dfcce6408aafb34fd783c9c2f75dccd7670f81599ed4ae51cfec0be9', '2025-06-12 17:02:09.331694-05', '20250612220208_make_invoice_fields_required', NULL, NULL, '2025-06-12 17:02:09.313121-05', 1);


--
-- TOC entry 4933 (class 0 OID 16928)
-- Dependencies: 226
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.companies VALUES ('cmbsj3d7v0000um9c91vyzwez', 'Brewsy', '900123457-7', 'contacto@brewsy.com.co', '+57 5 2825555', 'COP', 'America/Bogota', '', 'Calle 25 # 15-45, Centro', 'Sincelejo', 'Sucre', '700001', 'Colombia', '2025-06-11 22:35:38.539', '2025-06-11 23:45:28.224');


--
-- TOC entry 4935 (class 0 OID 17514)
-- Dependencies: 228
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.currencies VALUES (1, 'USD', 'Dólar Estadounidense', '$', 2, ',', '.', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (2, 'COP', 'Peso Colombiano', '$', 0, '.', ',', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (3, 'EUR', 'Euro', '€', 2, '.', ',', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (4, 'GBP', 'Libra Esterlina', '£', 2, ',', '.', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (5, 'CAD', 'Dólar Canadiense', 'C$', 2, ',', '.', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (6, 'AUD', 'Dólar Australiano', 'A$', 2, ',', '.', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (7, 'JPY', 'Yen Japonés', '¥', 0, ',', '.', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (8, 'CHF', 'Franco Suizo', 'CHF', 2, ',', '.', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (9, 'CNY', 'Yuan Chino', '¥', 2, ',', '.', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');
INSERT INTO public.currencies VALUES (10, 'MXN', 'Peso Mexicano', '$', 2, ',', '.', true, '2025-06-12 17:17:50.594', '2025-06-12 17:17:50.594');


--
-- TOC entry 4928 (class 0 OID 16596)
-- Dependencies: 221
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customers VALUES (1, 'Juan Pérez', 'juan.perez@email.com', '555-123-4567', '2025-05-30 17:30:25.205', '2025-05-30 17:30:25.205', NULL);
INSERT INTO public.customers VALUES (2, 'María García', 'maria.garcia@email.com', '555-987-6543', '2025-05-30 17:31:04.543', '2025-05-30 17:31:04.543', NULL);
INSERT INTO public.customers VALUES (3, 'Maria Ruby', 'maria.ruby@gmail.com', '456879166', '2025-06-03 00:34:27.322', '2025-06-03 00:34:27.322', NULL);
INSERT INTO public.customers VALUES (4, 'Pedro Alvarez', 'pedor.alvarez@gmail.com', '3054684569', '2025-06-03 13:53:15.103', '2025-06-03 13:53:15.103', NULL);
INSERT INTO public.customers VALUES (5, 'Homero Simpson', 'homero.simpson@gmail.com', '123456789', '2025-06-03 14:13:26.685', '2025-06-03 14:13:26.685', NULL);
INSERT INTO public.customers VALUES (6, 'Harold Samint', 'harold.samith@gmail.com', '3102556444', '2025-06-03 23:30:00.267', '2025-06-03 23:30:00.267', NULL);


--
-- TOC entry 4932 (class 0 OID 16617)
-- Dependencies: 225
-- Data for Name: sale_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sale_items VALUES (1, 2, 7.99, 1, 1);
INSERT INTO public.sale_items VALUES (2, 1, 7.99, 1, 2);
INSERT INTO public.sale_items VALUES (3, 1, 4500, 2, 6);
INSERT INTO public.sale_items VALUES (4, 4, 3000, 3, 5);
INSERT INTO public.sale_items VALUES (5, 3, 4000, 4, 2);
INSERT INTO public.sale_items VALUES (6, 4, 4500, 4, 6);
INSERT INTO public.sale_items VALUES (7, 10, 3000, 5, 8);
INSERT INTO public.sale_items VALUES (8, 1, 5500, 6, 3);
INSERT INTO public.sale_items VALUES (9, 1, 3000, 6, 8);
INSERT INTO public.sale_items VALUES (10, 4, 4000, 7, 4);
INSERT INTO public.sale_items VALUES (11, 2, 4000, 8, 7);
INSERT INTO public.sale_items VALUES (12, 2, 4000, 8, 2);
INSERT INTO public.sale_items VALUES (13, 3, 4500, 9, 6);
INSERT INTO public.sale_items VALUES (14, 6, 3500, 9, 9);
INSERT INTO public.sale_items VALUES (15, 3, 5500, 10, 3);
INSERT INTO public.sale_items VALUES (16, 2, 3000, 10, 8);
INSERT INTO public.sale_items VALUES (17, 2, 8500, 10, 12);
INSERT INTO public.sale_items VALUES (18, 4, 4000, 11, 2);
INSERT INTO public.sale_items VALUES (19, 4, 4500, 11, 6);
INSERT INTO public.sale_items VALUES (20, 5, 3500, 11, 9);
INSERT INTO public.sale_items VALUES (21, 2, 4000, 12, 11);
INSERT INTO public.sale_items VALUES (22, 2, 4000, 12, 4);
INSERT INTO public.sale_items VALUES (23, 2, 3000, 12, 8);


--
-- TOC entry 4930 (class 0 OID 16606)
-- Dependencies: 223
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sales VALUES (2, 4500, 20000, 15500, 'Efectivo', '2025-06-02 22:01:32.584', '2025-06-02 22:01:32.584', 2, 1, 'cmbsj3d7v0000um9c91vyzwez', '00002', 4050, 450, 10);
INSERT INTO public.sales VALUES (3, 12000, 50000, 38000, 'Efectivo', '2025-06-02 22:03:50.709', '2025-06-02 22:03:50.709', 2, 1, 'cmbsj3d7v0000um9c91vyzwez', '00003', 10800, 1200, 10);
INSERT INTO public.sales VALUES (4, 30000, 50000, 20000, 'Efectivo', '2025-06-02 23:08:02.466', '2025-06-02 23:08:02.466', 2, 2, 'cmbsj3d7v0000um9c91vyzwez', '00004', 27000, 3000, 10);
INSERT INTO public.sales VALUES (5, 30000, 50000, 20000, 'Efectivo', '2025-06-03 02:08:57.076', '2025-06-03 02:08:57.076', 3, 3, 'cmbsj3d7v0000um9c91vyzwez', '00005', 27000, 3000, 10);
INSERT INTO public.sales VALUES (6, 8500, 10000, 1500, 'Efectivo', '2025-06-03 13:53:58.357', '2025-06-03 13:53:58.357', 3, 4, 'cmbsj3d7v0000um9c91vyzwez', '00006', 7650, 850, 10);
INSERT INTO public.sales VALUES (1, 12000, 20000, 8000, 'Efectivo', '2025-05-30 17:32:37.442', '2025-05-30 17:32:37.442', 1, 1, 'cmbsj3d7v0000um9c91vyzwez', '00001', 10800, 1200, 10);
INSERT INTO public.sales VALUES (7, 16000, 200000, 184000, 'Efectivo', '2025-06-03 20:49:59.811', '2025-06-03 20:49:59.811', 3, 1, 'cmbsj3d7v0000um9c91vyzwez', '00007', 14400, 1600, 10);
INSERT INTO public.sales VALUES (8, 16000, 20000, 4000, 'Efectivo', '2025-06-03 23:28:36.558', '2025-06-03 23:28:36.558', 1, 2, 'cmbsj3d7v0000um9c91vyzwez', '00008', 14400, 1600, 10);
INSERT INTO public.sales VALUES (9, 34500, 100000, 65500, 'Efectivo', '2025-06-04 02:08:02.613', '2025-06-04 02:08:02.613', 3, 4, 'cmbsj3d7v0000um9c91vyzwez', '00009', 31050, 3450, 10);
INSERT INTO public.sales VALUES (10, 39500, 100000, 60500, 'Efectivo', '2025-06-05 02:23:20.456', '2025-06-05 02:23:20.456', 1, 3, 'cmbsj3d7v0000um9c91vyzwez', '00010', 35550, 3950, 10);
INSERT INTO public.sales VALUES (11, 51500, 60000, 8500, 'Efectivo', '2025-06-05 15:04:48.915', '2025-06-05 15:04:48.915', 1, 5, 'cmbsj3d7v0000um9c91vyzwez', '00011', 46350, 5150, 10);
INSERT INTO public.sales VALUES (12, 22000, 50000, 28000, 'Efectivo', '2025-06-05 21:44:21.255', '2025-06-05 21:44:21.255', 3, 4, 'cmbsj3d7v0000um9c91vyzwez', '00012', 19800, 2200, 10);


--
-- TOC entry 4937 (class 0 OID 17528)
-- Dependencies: 230
-- Data for Name: taxes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.taxes VALUES (1, 'IVA', 10, true, true, '2025-06-12 17:15:58.498', '2025-06-12 17:15:58.498');
INSERT INTO public.taxes VALUES (2, 'Impuesto al Consumo', 5, true, false, '2025-06-12 17:15:58.498', '2025-06-12 17:15:58.498');


--
-- TOC entry 4926 (class 0 OID 16586)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Juan Pérez', 'juan.perez@example.com', 'bartender', '2025-05-30 16:15:46.492', '2025-05-30 16:15:46.492');
INSERT INTO public.users VALUES (2, 'Carlos Rodríguez', 'carlos.rodriguez@example.com', 'bartender', '2025-05-30 16:18:05.703', '2025-05-30 16:18:05.703');
INSERT INTO public.users VALUES (3, 'Daniel Trejos', 'daniel.trejos@example.com', 'admin', '2025-05-30 16:19:14.622', '2025-05-30 16:19:14.622');


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 216
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 12, true);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 227
-- Name: currencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.currencies_id_seq', 10, true);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 220
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 6, true);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 224
-- Name: sale_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sale_items_id_seq', 23, true);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 222
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_id_seq', 12, true);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 229
-- Name: taxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxes_id_seq', 2, true);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 4755 (class 2606 OID 16535)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- TOC entry 4752 (class 2606 OID 16525)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4768 (class 2606 OID 16937)
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- TOC entry 4771 (class 2606 OID 17526)
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (id);


--
-- TOC entry 4760 (class 2606 OID 16604)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 4765 (class 2606 OID 16622)
-- Name: sale_items sale_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT sale_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4763 (class 2606 OID 16615)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- TOC entry 4773 (class 2606 OID 17538)
-- Name: taxes taxes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxes
    ADD CONSTRAINT taxes_pkey PRIMARY KEY (id);


--
-- TOC entry 4758 (class 2606 OID 16594)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4753 (class 1259 OID 16536)
-- Name: Product_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Product_name_key" ON public."Product" USING btree (name);


--
-- TOC entry 4766 (class 1259 OID 16938)
-- Name: companies_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX companies_email_key ON public.companies USING btree (email);


--
-- TOC entry 4769 (class 1259 OID 17539)
-- Name: currencies_code_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX currencies_code_key ON public.currencies USING btree (code);


--
-- TOC entry 4761 (class 1259 OID 17540)
-- Name: sales_invoiceNumber_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "sales_invoiceNumber_key" ON public.sales USING btree ("invoiceNumber");


--
-- TOC entry 4756 (class 1259 OID 16623)
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- TOC entry 4777 (class 2606 OID 16639)
-- Name: sale_items sale_items_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT "sale_items_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4778 (class 2606 OID 16634)
-- Name: sale_items sale_items_saleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT "sale_items_saleId_fkey" FOREIGN KEY ("saleId") REFERENCES public.sales(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4774 (class 2606 OID 18006)
-- Name: sales sales_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "sales_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public.companies(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4775 (class 2606 OID 16629)
-- Name: sales sales_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "sales_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4776 (class 2606 OID 16624)
-- Name: sales sales_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "sales_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2025-06-12 17:23:02

--
-- PostgreSQL database dump complete
--

