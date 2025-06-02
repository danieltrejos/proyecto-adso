--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2025-06-02 15:39:51

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
-- TOC entry 4901 (class 0 OID 0)
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
-- TOC entry 221 (class 1259 OID 16596)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name text NOT NULL,
    email text,
    phone text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
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
-- TOC entry 4902 (class 0 OID 0)
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
-- TOC entry 4903 (class 0 OID 0)
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
    "customerId" integer
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
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 222
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


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
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4714 (class 2604 OID 16530)
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- TOC entry 4718 (class 2604 OID 16599)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 4723 (class 2604 OID 16620)
-- Name: sale_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items ALTER COLUMN id SET DEFAULT nextval('public.sale_items_id_seq'::regclass);


--
-- TOC entry 4720 (class 2604 OID 16609)
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 16589)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4887 (class 0 OID 16527)
-- Dependencies: 217
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES (3, 'Duvel', 'Cerveza Roja', 5500, 'https://www.clubcolombia.com.co/sites/g/files/seuoyk481/files/2023-05/InternaRoja.png.webp', '2025-04-19 20:03:56.947', '2025-05-19 21:12:14.925', 112, 'Lager');
INSERT INTO public."Product" VALUES (4, 'Club colombia ', 'Cervezas club colombia 330ml ', 4000, NULL, '2025-04-20 18:45:49.469', '2025-05-20 00:52:39.408', 47, 'Cerveza');
INSERT INTO public."Product" VALUES (5, 'Aguila Light', 'Cerveza la Aguila Light 330ml', 3000, 'https://jotajotafoods.com/wp-content/uploads/2022/06/CER00037.jpg', '2025-04-20 19:34:50.599', '2025-05-20 12:51:05.595', 25, 'Lager');
INSERT INTO public."Product" VALUES (6, 'Heineken', 'Cerveza lager', 4500, 'heineken.com', '2025-05-21 00:36:06.229', '2025-05-21 00:36:31.912', 220, 'Lager');
INSERT INTO public."Product" VALUES (7, 'Aguila', 'Cerveza colombiana', 4000, 'https://www.clubcolombia.com.co/sites/g/files/seuoyk481/files/2023-05/InternaRoja.png.webp', '2025-04-19 20:01:30.853', '2025-05-30 14:11:55.016', 236, 'Lager');
INSERT INTO public."Product" VALUES (1, 'Malta', 'malta', 8000, NULL, '2025-04-20 19:56:23.724', '2025-05-30 17:32:37.452', 948, 'Lager');
INSERT INTO public."Product" VALUES (2, 'Costeña', 'Costena 330ml', 4000, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlBxST3savqc834LXLqzKBYkjHiRMA2vu8jQ&s', '2025-04-20 17:30:23', '2025-05-30 17:32:37.454', 199, 'Lager');


--
-- TOC entry 4885 (class 0 OID 16517)
-- Dependencies: 215
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public._prisma_migrations VALUES ('d7129d05-f687-4a21-8ad9-0e8b13c364e3', '90a6ca54ef2dcb3e2dd5aa30abc171d72835a9457a8a88ca15106208dece09fb', '2025-05-30 09:06:59.410138-05', '20250419143237_init', NULL, NULL, '2025-05-30 09:06:59.399015-05', 1);
INSERT INTO public._prisma_migrations VALUES ('07c3ee01-8b7a-4ce2-a64d-8dd96795e316', '553a08639f2f44e5bdcd5b6beca37fd9b74d753e8f85d0c9faca30ecd3aad0c4', '2025-05-30 09:06:59.412612-05', '20250419152118_stock_added', NULL, NULL, '2025-05-30 09:06:59.410515-05', 1);
INSERT INTO public._prisma_migrations VALUES ('6e5f0607-0c8a-43e3-9c5e-ecef932debbb', '4a1c438f0af05032d66f138e8333f4184e437ce5392701750ca275fff732beeb', '2025-05-30 09:06:59.415678-05', '20250419155426_product_name_require', NULL, NULL, '2025-05-30 09:06:59.412963-05', 1);
INSERT INTO public._prisma_migrations VALUES ('37188a7c-0a97-48e3-ad98-82355b17f31d', '65b09b229ed3f92818784af442e373855fe44ca7905bde7f64d5b3a0eee762e3', '2025-05-30 09:06:59.417979-05', '20250420163341_add_product_type', NULL, NULL, '2025-05-30 09:06:59.416195-05', 1);
INSERT INTO public._prisma_migrations VALUES ('9df2b27d-26ec-43ef-92e6-93332c6b9a4b', 'f8e950379afa5be27d7563e41951292618d9b180e411765b5e32490c8dd45d9c', '2025-05-30 09:57:52.822608-05', '20250530145752_add_sales_users_models', NULL, NULL, '2025-05-30 09:57:52.793284-05', 1);


--
-- TOC entry 4891 (class 0 OID 16596)
-- Dependencies: 221
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customers VALUES (1, 'Juan Pérez', 'juan.perez@email.com', '555-123-4567', '2025-05-30 17:30:25.205', '2025-05-30 17:30:25.205');
INSERT INTO public.customers VALUES (2, 'María García', 'maria.garcia@email.com', '555-987-6543', '2025-05-30 17:31:04.543', '2025-05-30 17:31:04.543');


--
-- TOC entry 4895 (class 0 OID 16617)
-- Dependencies: 225
-- Data for Name: sale_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sale_items VALUES (1, 2, 7.99, 1, 1);
INSERT INTO public.sale_items VALUES (2, 1, 7.99, 1, 2);


--
-- TOC entry 4893 (class 0 OID 16606)
-- Dependencies: 223
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sales VALUES (1, 23.97, 30, 6.03, 'Cash', '2025-05-30 17:32:37.442', '2025-05-30 17:32:37.442', 1, 1);


--
-- TOC entry 4889 (class 0 OID 16586)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Juan Pérez', 'juan.perez@example.com', 'bartender', '2025-05-30 16:15:46.492', '2025-05-30 16:15:46.492');
INSERT INTO public.users VALUES (2, 'Carlos Rodríguez', 'carlos.rodriguez@example.com', 'bartender', '2025-05-30 16:18:05.703', '2025-05-30 16:18:05.703');
INSERT INTO public.users VALUES (3, 'Daniel Trejos', 'daniel.trejos@example.com', 'admin', '2025-05-30 16:19:14.622', '2025-05-30 16:19:14.622');


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 216
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 7, true);


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 220
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 2, true);


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 224
-- Name: sale_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sale_items_id_seq', 2, true);


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 222
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_id_seq', 1, true);


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 4728 (class 2606 OID 16535)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- TOC entry 4725 (class 2606 OID 16525)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4733 (class 2606 OID 16604)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 4737 (class 2606 OID 16622)
-- Name: sale_items sale_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT sale_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4735 (class 2606 OID 16615)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- TOC entry 4731 (class 2606 OID 16594)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4726 (class 1259 OID 16536)
-- Name: Product_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Product_name_key" ON public."Product" USING btree (name);


--
-- TOC entry 4729 (class 1259 OID 16623)
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- TOC entry 4740 (class 2606 OID 16639)
-- Name: sale_items sale_items_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT "sale_items_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4741 (class 2606 OID 16634)
-- Name: sale_items sale_items_saleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT "sale_items_saleId_fkey" FOREIGN KEY ("saleId") REFERENCES public.sales(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4738 (class 2606 OID 16629)
-- Name: sales sales_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "sales_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4739 (class 2606 OID 16624)
-- Name: sales sales_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "sales_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2025-06-02 15:39:51

--
-- PostgreSQL database dump complete
--

