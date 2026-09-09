--
-- PostgreSQL database dump
--

\restrict 9EgnIAUTDrO654oUi2XS4cIJGiSQwJ0fCb3e7awpnXyIj4LnDBGPUvmoqm4UAWN

-- Dumped from database version 17.6 (Debian 17.6-0+deb13u1)
-- Dumped by pg_dump version 17.6 (Debian 17.6-0+deb13u1)

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

ALTER TABLE ONLY public.compras DROP CONSTRAINT compras_id_videojuego_fkey;
ALTER TABLE ONLY public.compras DROP CONSTRAINT compras_id_usuario_fkey;
ALTER TABLE ONLY public.videojuegos DROP CONSTRAINT videojuegos_pkey;
ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_correo_key;
ALTER TABLE ONLY public.empleados DROP CONSTRAINT empleados_pkey;
ALTER TABLE ONLY public.compras DROP CONSTRAINT compras_pkey;
ALTER TABLE public.videojuegos ALTER COLUMN id_videojuego DROP DEFAULT;
ALTER TABLE public.usuarios ALTER COLUMN id_usuario DROP DEFAULT;
ALTER TABLE public.empleados ALTER COLUMN id_empleado DROP DEFAULT;
ALTER TABLE public.compras ALTER COLUMN id_compra DROP DEFAULT;
DROP SEQUENCE public.videojuegos_id_videojuego_seq;
DROP TABLE public.videojuegos;
DROP SEQUENCE public.usuarios_id_usuario_seq;
DROP TABLE public.usuarios;
DROP SEQUENCE public.empleados_id_empleado_seq;
DROP TABLE public.empleados;
DROP SEQUENCE public.compras_id_compra_seq;
DROP TABLE public.compras;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: compras; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.compras (
    id_compra integer NOT NULL,
    id_usuario integer,
    id_videojuego integer,
    fecha timestamp without time zone DEFAULT now()
);


ALTER TABLE public.compras OWNER TO admin;

--
-- Name: compras_id_compra_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.compras_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compras_id_compra_seq OWNER TO admin;

--
-- Name: compras_id_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.compras_id_compra_seq OWNED BY public.compras.id_compra;


--
-- Name: empleados; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.empleados (
    id_empleado integer NOT NULL,
    nombre character varying(100),
    puesto character varying(50),
    salario numeric(10,2)
);


ALTER TABLE public.empleados OWNER TO admin;

--
-- Name: empleados_id_empleado_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.empleados_id_empleado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empleados_id_empleado_seq OWNER TO admin;

--
-- Name: empleados_id_empleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.empleados_id_empleado_seq OWNED BY public.empleados.id_empleado;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: adm_flask
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre character varying(50),
    apellido character varying(50),
    correo character varying(100),
    telefono character varying(20),
    direccion character varying(100),
    delegacion character varying(50),
    pais character varying(50),
    edad integer
);


ALTER TABLE public.usuarios OWNER TO adm_flask;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: adm_flask
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO adm_flask;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adm_flask
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- Name: videojuegos; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.videojuegos (
    id_videojuego integer NOT NULL,
    titulo character varying(100),
    genero character varying(50),
    precio numeric(10,2)
);


ALTER TABLE public.videojuegos OWNER TO admin;

--
-- Name: videojuegos_id_videojuego_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.videojuegos_id_videojuego_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.videojuegos_id_videojuego_seq OWNER TO admin;

--
-- Name: videojuegos_id_videojuego_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.videojuegos_id_videojuego_seq OWNED BY public.videojuegos.id_videojuego;


--
-- Name: compras id_compra; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.compras ALTER COLUMN id_compra SET DEFAULT nextval('public.compras_id_compra_seq'::regclass);


--
-- Name: empleados id_empleado; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.empleados ALTER COLUMN id_empleado SET DEFAULT nextval('public.empleados_id_empleado_seq'::regclass);


--
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: adm_flask
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- Name: videojuegos id_videojuego; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.videojuegos ALTER COLUMN id_videojuego SET DEFAULT nextval('public.videojuegos_id_videojuego_seq'::regclass);


--
-- Data for Name: compras; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.compras (id_compra, id_usuario, id_videojuego, fecha) FROM stdin;
1	1	1	2025-11-28 13:36:41.687371
2	1	1	2025-11-28 13:38:58.4311
3	1	1	2025-11-28 13:58:42.902067
4	2	1	2025-11-28 13:58:58.13148
\.


--
-- Data for Name: empleados; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.empleados (id_empleado, nombre, puesto, salario) FROM stdin;
1	David Martinez	Gerente	15000.00
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: adm_flask
--

COPY public.usuarios (id_usuario, nombre, apellido, correo, telefono, direccion, delegacion, pais, edad) FROM stdin;
1	Jose Alberto	Vazquez Lopez	zefvalo.152020@gmail.com	9511703166	Gustavo A. Madero	Gustavo A. Madero	Mexico	21
2	Blanca Edith	Lopez Hernandez	corazondeacero49@gmail.com	5532295579	Gustavo A. Madero	Gustavo A. Madero	Mexico	55
3	Juan Carlos	Pérez López	juancarlos1@mail.com	5512345678	Gustavo A. Madero	Benito Juárez	México	28
4	María Fernanda	Gómez Martínez	mariafernanda2@mail.com	5523456789	Gustavo A. Madero	Cuauhtémoc	México	34
5	Luis Miguel	Hernández Ramírez	luismiguel3@mail.com	5534567890	Gustavo A. Madero	Condesa	México	25
7	Carlos Eduardo	Vargas Morales	carloseduardo5@mail.com	5556789012	Gustavo A. Madero	Roma	México	27
8	Gabriela Isabel	Sánchez Ortega	gabriela6@mail.com	5567890123	Gustavo A. Madero	Juárez	México	32
9	Miguel Ángel	Ramírez Flores	miguelangel7@mail.com	5578901234	Gustavo A. Madero	Roma	México	29
11	Ricardo Alejandro	Mendoza Cruz	ricardo9@mail.com	5590123456	Gustavo A. Madero	Condensa	México	31
12	Paola Andrea	Jiménez Soto	paola10@mail.com	5512345679	Gustavo A. Madero	Benito Juárez	México	28
16	Camila Fernanda	Ortiz López	camila14@mail.com	5556789013	Gustavo A. Madero	Condesa	México	27
31	Ricardo Daniel	Paredes Ortega	ricardo29@mail.com	5523456792	Gustavo A. Madero	Roma	México	27
32	Marisol Valentina	Hernández Cruz	marisol30@mail.com	5534567893	Gustavo A. Madero	Condesa	México	29
33	Héctor Alejandro	Vega Torres	hector31@mail.com	5545678904	Gustavo A. Madero	Condesa	México	28
34	Daniela Sofía	Cruz Jiménez	daniela32@mail.com	5556789015	Gustavo A. Madero	Juárez	México	31
36	Carolina Isabel	González Flores	carolina34@mail.com	5578901237	Gustavo A. Madero	Roma	México	33
37	Javier Alejandro	Mendoza Pérez	javier35@mail.com	5589012348	Gustavo A. Madero	Benito Juárez	México	29
39	Miguel Ángel	Ortiz Hernández	miguel37@mail.com	5512345682	Gustavo A. Madero	Condesa	México	28
41	Laura Valentina	Gutiérrez Pérez	laura39@mail.com	5534567894	Gustavo A. Madero	Juárez	México	26
43	Monserrat Isabel	Torres Flores	monserrat41@mail.com	5556789016	Gustavo A. Madero	Roma	México	33
44	José Antonio	Vargas Jiménez	jose42@mail.com	5567890127	Gustavo A. Madero	Benito Juárez	México	27
46	Emilio Alejandro	González Pérez	emilio44@mail.com	5589012349	Gustavo A. Madero	Condesa	México	31
47	Valentina Isabel	Hernández Cruz	valentina45@mail.com	5590123460	Gustavo A. Madero	Roma	México	25
48	Diego Fernando	Mendoza Torres	diego46@mail.com	5512345683	Gustavo A. Madero	Roma	México	33
50	Ricardo Alejandro	Ortiz Flores	ricardo48@mail.com	5534567895	Gustavo A. Madero	Juárez	México	29
52	Santiago Daniel	Ramírez Pérez	santiago50@mail.com	5556789017	Gustavo A. Madero	Roma	México	31
6	Jose Vazquez	Torres Jiménez	anasofia4@mail.com	5545678901	Gustavo A. Madero	Coyoacán	México	30
10	Jose Vazquez	Castillo Rivera	valeria8@mail.com	5589012345	Gustavo A. Madero	Coyoacán	México	26
35	Jose Vazquez	Ramírez Ortega	victor33@mail.com	5567890126	Gustavo A. Madero	Coyoacán	México	25
38	Jose Vazquez	Ramírez Torres	paula36@mail.com	5590123459	Gustavo A. Madero	Coyoacán	México	27
40	Jose Vazquez	Hernández Morales	rene38@mail.com	5523456793	Gustavo A. Madero	Coyoacán	México	31
42	Jose Vazquez	Sánchez Ramírez	bruno40@mail.com	5545678905	Gustavo A. Madero	Coyoacán	México	29
45	Jose Vazquez	Ramírez Ortega	diana43@mail.com	5578901238	Gustavo A. Madero	Coyoacán	México	28
13	Fernando José	Gutiérrez Peña	fernando11@mail.com	5523456790	Gustavo A. Madero	Benito Juárez	México	33
14	Sofía Valentina	Hernández Navarro	sofia12@mail.com	5534567891	Gustavo A. Madero	Roma	México	24
17	José Luis	Paredes Rivera	joseluis15@mail.com	5567890124	Gustavo A. Madero	Roma	México	31
19	Eduardo Daniel	Flores Sánchez	eduardo17@mail.com	5589012346	Gustavo A. Madero	Juárez	México	28
20	Fernanda Paola	González Ramírez	fernanda18@mail.com	5590123457	Gustavo A. Madero	Roma	México	32
21	Andrés Manuel	Méndez Torres	andres19@mail.com	5512345680	Gustavo A. Madero	Condesa	México	30
23	Jorge Luis	Ramírez Pérez	jorge21@mail.com	5534567892	Gustavo A. Madero	Roma	México	29
24	Natalia Fernanda	García López	natalia22@mail.com	5545678903	Gustavo A. Madero	Benito Juárez	México	33
26	Jessica Paola	Ortiz Ramírez	jessica24@mail.com	5567890125	Gustavo A. Madero	Roma	México	31
27	Alan Rodrigo	Vargas Torres	alan25@mail.com	5578901236	Gustavo A. Madero	Condesa	México	26
29	Santiago José	Gómez Rojas	santiago27@mail.com	5590123458	Gustavo A. Madero	Condesa	México	32
30	Alejandra Fernanda	Jiménez Sánchez	alejandra28@mail.com	5512345681	Gustavo A. Madero	Benito Juárez	México	30
49	Jose Vazquez	Ramírez López	camila47@mail.com	5523456794	Gustavo A. Madero	Coyoacán	México	27
51	Jose Vazquez	Gutiérrez Sánchez	isabel49@mail.com	5545678906	Gustavo A. Madero	Coyoacán	México	28
15	Jose Vazquez	Vega Martínez	diego13@mail.com	5545678902	Gustavo A. Madero	Coyoacán	México	29
18	Jose Vazquez	Rojas Pérez	mariana16@mail.com	5578901235	Gustavo A. Madero	Coyoacán	México	26
22	Jose Vazquez	Cruz Morales	isabella20@mail.com	5523456791	Gustavo A. Madero	Coyoacán	México	25
25	Jose Vazquez	Hernández Jiménez	adrian23@mail.com	5556789014	Gustavo A. Madero	Coyoacán	México	27
28	Jose Vazquez	Mendoza Hernández	renata26@mail.com	5589012347	Gustavo A. Madero	Coyoacán	México	28
53	Natalia Isabel	Hernández López	natalia51@mail.com	5567890128	Gustavo A. Madero	Benito Juárez	México	25
54	Andrés Alejandro	Mendoza Ramírez	andres52@mail.com	5578901239	Gustavo A. Madero	Condesa	México	33
55	Valeria Fernanda	Gutiérrez Torres	valeria53@mail.com	5589012350	Gustavo A. Madero	Juárez	México	27
57	Mariana Isabel	Pérez Torres	mariana55@mail.com	5512345684	Gustavo A. Madero	Roma	México	31
59	Paola Sofía	González Pérez	paola57@mail.com	5534567896	Gustavo A. Madero	Roma	México	29
60	Eduardo Miguel	Ramírez Torres	eduardo58@mail.com	5545678907	Gustavo A. Madero	Benito Juárez	México	28
56	Jose Vazquez	Ramírez Hernández	joaquin54@mail.com	5590123461	Gustavo A. Madero	Coyoacán	México	28
58	Jose Vazquez	Hernández Cruz	alejandro56@mail.com	5523456795	Gustavo A. Madero	Coyoacán	México	27
\.


--
-- Data for Name: videojuegos; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.videojuegos (id_videojuego, titulo, genero, precio) FROM stdin;
1	Smash Bros Ultimate	Arcade	2000.00
\.


--
-- Name: compras_id_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.compras_id_compra_seq', 4, true);


--
-- Name: empleados_id_empleado_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.empleados_id_empleado_seq', 1, true);


--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: adm_flask
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 62, true);


--
-- Name: videojuegos_id_videojuego_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.videojuegos_id_videojuego_seq', 1, true);


--
-- Name: compras compras_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id_compra);


--
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id_empleado);


--
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: adm_flask
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: adm_flask
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- Name: videojuegos videojuegos_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.videojuegos
    ADD CONSTRAINT videojuegos_pkey PRIMARY KEY (id_videojuego);


--
-- Name: compras compras_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: compras compras_id_videojuego_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES public.videojuegos(id_videojuego);


--
-- PostgreSQL database dump complete
--

\unrestrict 9EgnIAUTDrO654oUi2XS4cIJGiSQwJ0fCb3e7awpnXyIj4LnDBGPUvmoqm4UAWN

