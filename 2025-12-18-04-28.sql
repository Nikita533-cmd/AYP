--
-- PostgreSQL database dump
--

\restrict MS4scBUqUUKLxBAfYpC3kvRQDrysstFS4sly2BWcLgcolajnYlCn06pswNxrEc4

-- Dumped from database version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)

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

ALTER TABLE ONLY public.users_user_user_permissions DROP CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id;
ALTER TABLE ONLY public.users_user_user_permissions DROP CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm;
ALTER TABLE ONLY public.users_user_groups DROP CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id;
ALTER TABLE ONLY public.users_user_groups DROP CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id;
ALTER TABLE ONLY public.users_calculateresult DROP CONSTRAINT users_calculateresults_user_id_e1a32400_fk_users_user_id;
ALTER TABLE ONLY public.tubes_type DROP CONSTRAINT tubes_type_tube_type_id_392b3b62_fk_tubes_tubetype_id;
ALTER TABLE ONLY public.management_node_controlunit DROP CONSTRAINT management_node_cont_control_unit_name_id_b7084b30_fk_managemen;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX public.users_user_username_06e46fe6_like;
DROP INDEX public.users_user_user_permissions_user_id_20aca447;
DROP INDEX public.users_user_user_permissions_permission_id_0b93982e;
DROP INDEX public.users_user_groups_user_id_5f6f5a90;
DROP INDEX public.users_user_groups_group_id_9afc8d0e;
DROP INDEX public.users_calculateresults_user_id_e1a32400;
DROP INDEX public.tubes_type_tube_type_id_392b3b62;
DROP INDEX public.management_node_controlunit_control_unit_name_id_b7084b30;
DROP INDEX public.django_session_session_key_c0390e0f_like;
DROP INDEX public.django_session_expire_date_a5c62663;
DROP INDEX public.django_admin_log_user_id_c564eba6;
DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX public.auth_permission_content_type_id_2f476e4b;
DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX public.auth_group_name_a6ea08ec_like;
ALTER TABLE ONLY public.users_user DROP CONSTRAINT users_user_username_key;
ALTER TABLE ONLY public.users_user_user_permissions DROP CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq;
ALTER TABLE ONLY public.users_user_user_permissions DROP CONSTRAINT users_user_user_permissions_pkey;
ALTER TABLE ONLY public.users_user DROP CONSTRAINT users_user_pkey;
ALTER TABLE ONLY public.users_user_groups DROP CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq;
ALTER TABLE ONLY public.users_user_groups DROP CONSTRAINT users_user_groups_pkey;
ALTER TABLE ONLY public.users_calculateresult DROP CONSTRAINT users_calculateresults_pkey;
ALTER TABLE ONLY public.tubes_type DROP CONSTRAINT tubes_type_pkey;
ALTER TABLE ONLY public.tubes_tubetype DROP CONSTRAINT tubes_tubetype_pkey;
ALTER TABLE ONLY public.sprinkler_sprinkler DROP CONSTRAINT sprinkler_sprinkler_pkey;
ALTER TABLE ONLY public.management_node_controlunitname DROP CONSTRAINT management_node_controlunitname_pkey;
ALTER TABLE ONLY public.management_node_controlunit DROP CONSTRAINT management_node_controlunit_pkey;
ALTER TABLE ONLY public.main_seosettings DROP CONSTRAINT main_seosettings_pkey;
ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
DROP TABLE public.users_user_user_permissions;
DROP TABLE public.users_user_groups;
DROP TABLE public.users_user;
DROP TABLE public.users_calculateresult;
DROP TABLE public.tubes_type;
DROP TABLE public.tubes_tubetype;
DROP TABLE public.sprinkler_sprinkler;
DROP TABLE public.management_node_controlunitname;
DROP TABLE public.management_node_controlunit;
DROP TABLE public.main_seosettings;
DROP TABLE public.django_session;
DROP TABLE public.django_migrations;
DROP TABLE public.django_content_type;
DROP TABLE public.django_admin_log;
DROP TABLE public.auth_permission;
DROP TABLE public.auth_group_permissions;
DROP TABLE public.auth_group;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO specauto;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO specauto;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO specauto;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO specauto;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO specauto;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO specauto;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO specauto;

--
-- Name: main_seosettings; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.main_seosettings (
    id bigint NOT NULL,
    meta_tags text NOT NULL,
    counters text NOT NULL
);


ALTER TABLE public.main_seosettings OWNER TO specauto;

--
-- Name: main_seosettings_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.main_seosettings ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_seosettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: management_node_controlunit; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.management_node_controlunit (
    id bigint NOT NULL,
    designation character varying(255) NOT NULL,
    diameter numeric(10,1) NOT NULL,
    pressure_loss numeric(15,15) NOT NULL,
    control_unit_name_id bigint NOT NULL,
    installation_type character varying(50) NOT NULL
);


ALTER TABLE public.management_node_controlunit OWNER TO specauto;

--
-- Name: management_node_controlunit_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.management_node_controlunit ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.management_node_controlunit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: management_node_controlunitname; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.management_node_controlunitname (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.management_node_controlunitname OWNER TO specauto;

--
-- Name: management_node_controlunitname_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.management_node_controlunitname ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.management_node_controlunitname_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sprinkler_sprinkler; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.sprinkler_sprinkler (
    id bigint NOT NULL,
    name character varying(500) NOT NULL,
    diameter numeric(5,2),
    mu numeric(5,3),
    "Pmax" numeric(5,3),
    "Pmin" numeric(5,3),
    k0 numeric(5,4),
    k1 numeric(5,4),
    k2 numeric(5,4),
    k3 numeric(5,4),
    k4 numeric(5,4),
    k5 numeric(5,4),
    otv_type character varying(50) NOT NULL,
    "intensity_Pmax" numeric(8,5),
    "intensity_Pmin" numeric(8,5),
    groups character varying(255)[],
    "S" numeric(5,1),
    thermal_lock character varying(100) NOT NULL,
    mounting_position character varying(100) NOT NULL,
    "K" numeric(6,3)
);


ALTER TABLE public.sprinkler_sprinkler OWNER TO specauto;

--
-- Name: sprinkler_sprinkler_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.sprinkler_sprinkler ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sprinkler_sprinkler_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tubes_tubetype; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.tubes_tubetype (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.tubes_tubetype OWNER TO specauto;

--
-- Name: tubes_tubetype_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.tubes_tubetype ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tubes_tubetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tubes_type; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.tubes_type (
    id bigint NOT NULL,
    nom_size numeric(10,1) NOT NULL,
    ext_size numeric(10,1) NOT NULL,
    thickness numeric(10,1) NOT NULL,
    k_t numeric(15,4) NOT NULL,
    tube_type_id bigint NOT NULL
);


ALTER TABLE public.tubes_type OWNER TO specauto;

--
-- Name: tubes_type_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.tubes_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tubes_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_calculateresult; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.users_calculateresult (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    data jsonb NOT NULL,
    user_id bigint
);


ALTER TABLE public.users_calculateresult OWNER TO specauto;

--
-- Name: users_user; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.users_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    parent_name character varying(100)
);


ALTER TABLE public.users_user OWNER TO specauto;

--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.users_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_user_groups OWNER TO specauto;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.users_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.users_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: specauto
--

CREATE TABLE public.users_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_user_permissions OWNER TO specauto;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: specauto
--

ALTER TABLE public.users_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Группа	6	add_usergroup
22	Can change Группа	6	change_usergroup
23	Can delete Группа	6	delete_usergroup
24	Can view Группа	6	view_usergroup
25	Can add Пользователь	7	add_user
26	Can change Пользователь	7	change_user
27	Can delete Пользователь	7	delete_user
28	Can view Пользователь	7	view_user
29	Can add Ороситель	8	add_sprinkler
30	Can change Ороситель	8	change_sprinkler
31	Can delete Ороситель	8	delete_sprinkler
32	Can view Ороситель	8	view_sprinkler
33	Can add Настройки SEO	9	add_seosettings
34	Can change Настройки SEO	9	change_seosettings
35	Can delete Настройки SEO	9	delete_seosettings
36	Can view Настройки SEO	9	view_seosettings
37	Can add type	10	add_type
38	Can change type	10	change_type
39	Can delete type	10	delete_type
40	Can view type	10	view_type
41	Can add tube type	11	add_tubetype
42	Can change tube type	11	change_tubetype
43	Can delete tube type	11	delete_tubetype
44	Can view tube type	11	view_tubetype
45	Can add control unit name	12	add_controlunitname
46	Can change control unit name	12	change_controlunitname
47	Can delete control unit name	12	delete_controlunitname
48	Can view control unit name	12	view_controlunitname
49	Can add control unit	13	add_controlunit
50	Can change control unit	13	change_controlunit
51	Can delete control unit	13	delete_controlunit
52	Can view control unit	13	view_controlunit
53	Can add Результат расчета	14	add_calculateresult
54	Can change Результат расчета	14	change_calculateresult
55	Can delete Результат расчета	14	delete_calculateresult
56	Can view Результат расчета	14	view_calculateresult
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-08-09 00:57:15.020752+00	17	Sprinkler object (17)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
2	2024-08-09 00:57:15.103019+00	18	Sprinkler object (18)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
3	2024-08-09 00:57:15.112624+00	19	Sprinkler object (19)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
4	2024-08-09 00:57:15.11942+00	20	Sprinkler object (20)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
5	2024-08-09 01:01:19.939549+00	65	Sprinkler object (65)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
6	2024-08-09 01:01:19.943172+00	67	Sprinkler object (67)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
7	2024-08-09 01:01:19.94644+00	68	Sprinkler object (68)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
8	2024-08-09 01:01:19.949295+00	71	Sprinkler object (71)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
9	2024-08-09 01:01:19.952474+00	73	Sprinkler object (73)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
10	2024-08-09 01:03:23.209719+00	69	Sprinkler object (69)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
11	2024-08-09 01:03:23.21361+00	74	Sprinkler object (74)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
12	2024-08-09 01:10:26.683318+00	29	Sprinkler object (29)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
13	2024-08-09 01:10:26.687656+00	78	Sprinkler object (78)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
14	2024-08-09 01:11:32.100781+00	79	Sprinkler object (79)	1	[{"added": {}}]	8	1
15	2024-08-09 01:12:21.467535+00	80	Sprinkler object (80)	1	[{"added": {}}]	8	1
16	2024-08-09 01:12:56.897088+00	81	Sprinkler object (81)	1	[{"added": {}}]	8	1
17	2024-08-09 01:13:30.551602+00	82	Sprinkler object (82)	1	[{"added": {}}]	8	1
18	2024-08-09 01:15:02.986105+00	31	Sprinkler object (31)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
19	2024-08-09 01:15:52.994416+00	83	Sprinkler object (83)	1	[{"added": {}}]	8	1
20	2024-08-09 01:19:57.816142+00	34	Sprinkler object (34)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
21	2024-08-09 01:22:07.547072+00	35	Sprinkler object (35)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
22	2024-08-09 01:22:59.780226+00	35	Sprinkler object (35)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
23	2024-08-09 01:23:22.641457+00	36	Sprinkler object (36)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
24	2024-08-09 01:24:01.427454+00	36	Sprinkler object (36)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
25	2024-08-09 01:24:57.903945+00	37	Sprinkler object (37)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
26	2024-08-09 01:25:38.841427+00	37	Sprinkler object (37)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
27	2024-08-09 01:25:38.844506+00	90	Sprinkler object (90)	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
28	2024-08-09 01:26:08.74889+00	38	Sprinkler object (38)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
29	2024-08-09 01:26:45.39562+00	38	Sprinkler object (38)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
30	2024-08-09 01:26:45.399326+00	91	Sprinkler object (91)	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
31	2024-08-09 01:27:43.210547+00	39	Sprinkler object (39)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412", "\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
32	2024-08-09 01:29:23.517262+00	39	Sprinkler object (39)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
33	2024-08-09 01:29:23.524162+00	92	Sprinkler object (92)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
79	2024-08-14 05:24:16.515492+00	107	СУУ-15	1	[{"added": {}}]	8	3
34	2024-08-09 01:29:57.638151+00	39	Sprinkler object (39)	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
35	2024-08-09 01:29:57.641877+00	92	Sprinkler object (92)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
36	2024-08-09 01:30:09.134845+00	92	Sprinkler object (92)	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
37	2024-08-09 01:31:04.69463+00	40	Sprinkler object (40)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
38	2024-08-09 01:31:23.347772+00	40	Sprinkler object (40)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
39	2024-08-09 01:31:51.199382+00	96	Sprinkler object (96)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
40	2024-08-09 01:32:06.580165+00	40	Sprinkler object (40)	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
41	2024-08-09 01:32:06.583382+00	96	Sprinkler object (96)	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
42	2024-08-09 01:32:57.326934+00	40	Sprinkler object (40)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
43	2024-08-09 01:32:57.330442+00	96	Sprinkler object (96)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
44	2024-08-09 02:32:45.594487+00	98	Sprinkler object (98)	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	1
45	2024-08-09 02:33:16.3833+00	23	Sprinkler object (23)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	1
46	2024-08-09 02:33:16.388809+00	98	Sprinkler object (98)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	1
47	2024-08-09 02:40:53.584103+00	2	None None	1	[{"added": {}}]	7	1
48	2024-08-09 02:41:27.244409+00	2	None None	3		7	1
49	2024-08-14 03:40:52.582803+00	79	SU-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
50	2024-08-14 03:40:52.920678+00	80	SSU-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
51	2024-08-14 04:44:51.334163+00	84	SSU-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
52	2024-08-14 04:48:51.098513+00	82	SSP-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
53	2024-08-14 04:49:40.390025+00	33	SSP-К80	3		8	3
54	2024-08-14 04:50:01.763162+00	82	SSP-К80	3		8	3
55	2024-08-14 04:50:23.070753+00	81	SP-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
56	2024-08-14 04:51:51.384186+00	99	SP-К80	1	[{"added": {}}]	8	3
57	2024-08-14 04:52:04.857635+00	100	SSP-К80	1	[{"added": {}}]	8	3
58	2024-08-14 04:53:06.888814+00	99	SP-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
80	2024-08-14 05:24:52.928492+00	108	СУУ-К160	1	[{"added": {}}]	8	3
81	2024-08-14 05:25:18.020793+00	25	СУУ-К160	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	3
289	2025-07-06 04:55:27.197783+00	2	Стальные электросварные по ГОСТ 10704 DN 20	1	[{"added": {}}]	10	4
59	2024-08-14 04:53:06.940445+00	100	SSP-К80	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
60	2024-08-14 05:09:41.697081+00	53	ДВВ-8	3		8	3
61	2024-08-14 05:12:42.416389+00	101	ДВН-8	1	[{"added": {}}]	8	3
62	2024-08-14 05:12:56.242244+00	101	ДВН-8	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
63	2024-08-14 05:13:00.292418+00	101	ДВН-8	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3"]}}]	8	3
64	2024-08-14 05:16:24.234391+00	102	СОБР-17	1	[{"added": {}}]	8	3
65	2024-08-14 05:16:40.474052+00	102	СОБР-17-Н	2	[{"changed": {"fields": ["\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435"]}}]	8	3
66	2024-08-14 05:17:10.892426+00	102	СОБР-17-Н	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
67	2024-08-14 05:17:21.718678+00	103	СОБР-17-В	1	[{"added": {}}]	8	3
68	2024-08-14 05:17:49.362382+00	103	СОБР-17-В	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
69	2024-08-14 05:18:06.052055+00	104	СОБР-25-Н	1	[{"added": {}}]	8	3
70	2024-08-14 05:18:11.213943+00	105	СОБР-25-В	1	[{"added": {}}]	8	3
71	2024-08-14 05:19:00.92881+00	104	СОБР-25-Н	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
72	2024-08-14 05:19:00.944548+00	105	СОБР-25-В	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
73	2024-08-14 05:20:55.152858+00	70	ДУУ-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
74	2024-08-14 05:21:16.281833+00	21	СУУ-К80	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	3
75	2024-08-14 05:21:22.95775+00	106	СУУ-К80	1	[{"added": {}}]	8	3
76	2024-08-14 05:21:35.936215+00	106	СУУ-К80	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
77	2024-08-14 05:23:25.514249+00	72	ДУУ-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
78	2024-08-14 05:24:09.282085+00	24	СУУ-15	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u041e\\u0422\\u0412"]}}]	8	3
82	2024-08-14 05:25:18.025363+00	108	СУУ-К160	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
83	2024-08-14 05:26:41.371752+00	22	СУУ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
84	2024-08-14 05:26:41.376346+00	66	ДУУ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
85	2024-08-14 05:26:49.085539+00	109	СУУ-12	1	[{"added": {}}]	8	3
86	2024-08-14 05:27:17.700031+00	71	ДУУ-12	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	3
87	2024-08-14 05:27:17.70384+00	109	СУУ-12	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
88	2024-08-14 05:27:44.129549+00	25	СУУ-К160	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	3
89	2024-08-14 05:34:58.103104+00	83	SU-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
90	2024-08-18 03:17:36.458134+00	107	СУУ-15	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041c\\u0430\\u043a\\u0441. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0"]}}]	8	3
91	2024-08-18 05:41:09.774111+00	67	ДУУ-К115	2	[{"changed": {"fields": ["\\u041c\\u0438\\u043d. \\u0440\\u0430\\u0431\\u043e\\u0447\\u0435\\u0435 \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435, \\u041c\\u041f\\u0430"]}}]	8	3
92	2024-08-25 02:25:48.097712+00	9	СВН-8	3		8	1
93	2024-08-25 02:25:57.504289+00	1	СВВ-8	3		8	1
94	2024-08-25 02:26:07.341713+00	10	СВН-К57	3		8	1
95	2024-08-25 02:26:16.339452+00	2	СВВ-К57	3		8	1
96	2024-08-25 02:26:26.310622+00	101	ДВН-8	3		8	1
97	2024-08-25 02:26:35.725702+00	45	ДВВ-8	3		8	1
98	2024-08-25 02:26:45.136393+00	54	ДВН-К57	3		8	1
99	2024-08-25 02:26:55.418655+00	46	ДВВ-К57	3		8	1
100	2024-08-25 12:15:44.475873+00	15	СВН-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
101	2024-08-25 12:15:44.479822+00	16	СВН-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
102	2024-08-25 12:15:44.482988+00	56	СВН-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
103	2024-08-25 12:15:44.486445+00	58	СВН-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
104	2024-08-25 12:15:44.489423+00	59	СВН-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
105	2024-08-25 12:15:44.492309+00	61	СВН-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
106	2024-08-25 12:16:02.450649+00	3	СВВ-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
107	2024-08-25 12:16:02.455682+00	4	СВВ-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
108	2024-08-25 12:16:02.462805+00	5	СВВ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
109	2024-08-25 12:16:02.473092+00	6	СВВ-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
110	2024-08-25 12:16:02.486044+00	7	СВВ-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
111	2024-08-25 12:16:02.495206+00	8	СВВ-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
112	2024-08-25 12:16:10.117885+00	26	СВУ-8	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
113	2024-08-25 12:16:10.126069+00	27	СВУ-К57	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
114	2024-08-25 12:16:10.14671+00	28	СВУ-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
115	2024-08-25 12:16:21.364482+00	30	SSP-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
116	2024-08-25 12:16:21.373436+00	32	SSP-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
117	2024-08-25 12:16:21.376585+00	34	SSP-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
118	2024-08-25 12:16:21.390566+00	100	SSP-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
119	2024-08-25 12:16:31.133819+00	29	SSU-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
120	2024-08-25 12:16:31.137349+00	31	SSU-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
121	2024-08-25 12:16:31.140984+00	80	SSU-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
122	2024-08-25 12:16:31.143655+00	84	SSU-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
123	2024-08-25 12:16:45.252776+00	81	SP-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
124	2024-08-25 12:16:45.258077+00	86	SP-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
125	2024-08-25 12:16:45.268006+00	87	SP-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
126	2024-08-25 12:16:45.280544+00	99	SP-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
127	2024-08-25 12:16:53.487462+00	78	SU-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
128	2024-08-25 12:16:53.491552+00	79	SU-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
129	2024-08-25 12:16:53.494974+00	83	SU-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
130	2024-08-25 12:16:53.500453+00	85	SU-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
131	2024-08-25 12:17:53.935916+00	21	СУУ-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
132	2024-08-25 12:17:53.939816+00	22	СУУ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
133	2024-08-25 12:17:53.943686+00	23	СУУ-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
134	2024-08-25 12:17:53.948965+00	24	СУУ-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
135	2024-08-25 12:17:53.951802+00	25	СУУ-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
136	2024-08-25 12:17:53.955395+00	98	СУУ-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
137	2024-08-25 12:17:53.961233+00	106	СУУ-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
138	2024-08-25 12:17:53.964344+00	107	СУУ-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
139	2024-08-25 12:17:53.968174+00	108	СУУ-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
140	2024-08-25 12:17:53.971314+00	109	СУУ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
141	2024-08-25 12:18:12.486802+00	17	СОБР-17-Н	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
142	2024-08-25 12:18:12.490957+00	18	СОБР-17-В	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
143	2024-08-25 12:18:12.49452+00	19	СОБР-25-Н	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
144	2024-08-25 12:18:12.49772+00	20	СОБР-25-В	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
145	2024-08-25 12:18:12.505329+00	102	СОБР-17-Н	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
146	2024-08-25 12:18:12.508539+00	103	СОБР-17-В	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
147	2024-08-25 12:18:12.511264+00	104	СОБР-25-Н	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
148	2024-08-25 12:18:12.513964+00	105	СОБР-25-В	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
149	2024-08-25 12:18:49.453773+00	40	СУН-К200	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
150	2024-08-25 12:18:49.46337+00	95	СУН-К200	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
151	2024-08-25 12:19:07.60646+00	11	СВК-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
152	2024-08-25 12:19:07.615728+00	12	СВК-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
287	2025-07-06 04:54:14.429214+00	2	Стальные водогазопроводные по ГОСТ 3262	1	[{"added": {}}]	11	4
153	2024-08-25 12:19:07.622612+00	13	СВК-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
154	2024-08-25 12:19:07.625468+00	14	СВК-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
155	2024-08-25 12:19:30.41568+00	41	ССН-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
156	2024-08-25 12:19:30.429254+00	42	ССН-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
157	2024-08-25 12:19:39.159897+00	43	ССВ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
158	2024-08-25 12:19:39.163865+00	44	ССВ-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
159	2024-08-25 12:20:03.780752+00	37	ОЦ-9	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
160	2024-08-25 12:20:03.787748+00	38	ОЦ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
161	2024-08-25 12:20:03.791018+00	90	ОЦ-9	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
162	2024-08-25 12:20:03.795699+00	91	ОЦ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
163	2024-08-25 12:20:11.084647+00	35	ОЭ-16	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
164	2024-08-25 12:20:11.088727+00	36	ОЭ-25	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
165	2024-08-25 12:20:11.100157+00	88	ОЭ-16	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
166	2024-08-25 12:20:11.102955+00	89	ОЭ-25	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
167	2024-08-25 12:21:13.282938+00	39	СУВ-К200	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
168	2024-08-27 03:19:34.588061+00	55	ДВН-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
169	2024-08-27 03:19:34.952956+00	57	ДВН-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
170	2024-08-27 03:19:34.956922+00	60	ДВН-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
171	2024-08-27 03:19:34.960573+00	62	ДВН-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
172	2024-08-27 03:19:34.965881+00	63	ДВН-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
173	2024-08-27 03:19:34.968981+00	64	ДВН-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
174	2024-08-27 03:19:58.880921+00	47	ДВВ-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
175	2024-08-27 03:19:58.884559+00	48	ДВВ-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
176	2024-08-27 03:19:58.887913+00	49	ДВВ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
177	2024-08-27 03:19:58.890727+00	50	ДВВ-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
178	2024-08-27 03:19:58.90357+00	51	ДВВ-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
179	2024-08-27 03:19:58.906526+00	52	ДВВ-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
180	2024-08-27 03:20:20.605433+00	75	ДВУ-8	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
181	2024-08-27 03:20:20.612015+00	76	ДВУ-К57	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
182	2024-08-27 03:20:20.617872+00	77	ДВУ-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
183	2024-08-27 03:22:40.976819+00	65	ДУУ-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
184	2024-08-27 03:22:40.98086+00	66	ДУУ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
185	2024-08-27 03:22:40.98384+00	67	ДУУ-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
186	2024-08-27 03:22:40.986808+00	68	ДУУ-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
187	2024-08-27 03:22:40.989818+00	69	ДУУ-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
188	2024-08-27 03:22:40.992527+00	70	ДУУ-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
189	2024-08-27 03:22:40.995378+00	71	ДУУ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
190	2024-08-27 03:22:40.998093+00	72	ДУУ-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
191	2024-08-27 03:22:41.005024+00	73	ДУУ-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
192	2024-08-27 03:22:41.008936+00	74	ДУУ-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
193	2024-08-27 03:23:28.313274+00	96	ДУН-К200	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
194	2024-08-27 03:23:28.317304+00	97	ДУН-К200	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
195	2024-08-27 03:23:39.330773+00	92	ДУВ-К200	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
196	2024-08-27 03:23:39.334726+00	93	ДУВ-К200	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
197	2024-08-27 03:41:03.260114+00	94	CУВ-К200	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
198	2024-10-01 07:20:47.53651+00	17	СОБР-17-Н	2	[{"changed": {"fields": ["\\u041d\\u0430\\u043b\\u0438\\u0447\\u0438\\u0435 \\u0442\\u0435\\u043f\\u043b\\u043e\\u0432\\u043e\\u0433\\u043e \\u0437\\u0430\\u043c\\u043a\\u0430"]}}]	8	1
199	2024-10-01 07:20:53.217917+00	18	СОБР-17-В	2	[{"changed": {"fields": ["\\u041d\\u0430\\u043b\\u0438\\u0447\\u0438\\u0435 \\u0442\\u0435\\u043f\\u043b\\u043e\\u0432\\u043e\\u0433\\u043e \\u0437\\u0430\\u043c\\u043a\\u0430"]}}]	8	1
200	2024-10-01 07:20:57.316208+00	19	СОБР-25-Н	2	[{"changed": {"fields": ["\\u041d\\u0430\\u043b\\u0438\\u0447\\u0438\\u0435 \\u0442\\u0435\\u043f\\u043b\\u043e\\u0432\\u043e\\u0433\\u043e \\u0437\\u0430\\u043c\\u043a\\u0430"]}}]	8	1
201	2024-10-01 07:21:01.793621+00	20	СОБР-25-В	2	[{"changed": {"fields": ["\\u041d\\u0430\\u043b\\u0438\\u0447\\u0438\\u0435 \\u0442\\u0435\\u043f\\u043b\\u043e\\u0432\\u043e\\u0433\\u043e \\u0437\\u0430\\u043c\\u043a\\u0430"]}}]	8	1
202	2024-10-01 07:21:06.261977+00	103	СОБР-17-В	2	[{"changed": {"fields": ["\\u041d\\u0430\\u043b\\u0438\\u0447\\u0438\\u0435 \\u0442\\u0435\\u043f\\u043b\\u043e\\u0432\\u043e\\u0433\\u043e \\u0437\\u0430\\u043c\\u043a\\u0430"]}}]	8	1
203	2024-10-01 07:21:10.175141+00	104	СОБР-25-Н	2	[{"changed": {"fields": ["\\u041d\\u0430\\u043b\\u0438\\u0447\\u0438\\u0435 \\u0442\\u0435\\u043f\\u043b\\u043e\\u0432\\u043e\\u0433\\u043e \\u0437\\u0430\\u043c\\u043a\\u0430"]}}]	8	1
204	2024-10-01 07:21:13.933996+00	105	СОБР-25-В	2	[{"changed": {"fields": ["\\u041d\\u0430\\u043b\\u0438\\u0447\\u0438\\u0435 \\u0442\\u0435\\u043f\\u043b\\u043e\\u0432\\u043e\\u0433\\u043e \\u0437\\u0430\\u043c\\u043a\\u0430"]}}]	8	1
205	2024-10-02 03:15:20.319105+00	41	ССН-12 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041f\\u043b\\u043e\\u0449\\u0430\\u0434\\u044c \\u043e\\u0440\\u043e\\u0448\\u0435\\u043d\\u0438\\u044f, \\u043c\\u00b2"]}}]	8	1
206	2024-10-02 03:17:28.141849+00	42	ССН-15 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041f\\u043b\\u043e\\u0449\\u0430\\u0434\\u044c \\u043e\\u0440\\u043e\\u0448\\u0435\\u043d\\u0438\\u044f, \\u043c\\u00b2"]}}]	8	1
207	2024-10-02 03:21:16.824654+00	112	ССН-12 (S=3 м²)	1	[{"added": {}}]	8	1
208	2024-10-02 03:26:45.784432+00	113	ССН-15 (S=3 м²)	1	[{"added": {}}]	8	1
209	2024-10-02 03:28:31.537194+00	43	ССВ-12 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041f\\u043b\\u043e\\u0449\\u0430\\u0434\\u044c \\u043e\\u0440\\u043e\\u0448\\u0435\\u043d\\u0438\\u044f, \\u043c\\u00b2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5"]}}]	8	1
210	2024-10-02 03:30:10.364139+00	43	ССВ-12 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k0", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k4", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k5"]}}]	8	1
211	2024-10-02 03:31:14.407116+00	44	ССВ-15 (S=3 м²)	2	[{"changed": {"fields": ["\\u041f\\u043b\\u043e\\u0449\\u0430\\u0434\\u044c \\u043e\\u0440\\u043e\\u0448\\u0435\\u043d\\u0438\\u044f, \\u043c\\u00b2"]}}]	8	1
212	2024-10-02 03:32:36.619844+00	114	ССВ-15 (S=3 м²)	1	[{"added": {}}]	8	1
213	2024-10-02 03:33:30.535535+00	114	ССВ-15 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041f\\u043b\\u043e\\u0449\\u0430\\u0434\\u044c \\u043e\\u0440\\u043e\\u0448\\u0435\\u043d\\u0438\\u044f, \\u043c\\u00b2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k1", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k2", "\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 k3"]}}]	8	1
214	2024-10-02 03:34:55.946923+00	115	ССВ-12 (S=3 м²)	1	[{"added": {}}]	8	1
215	2024-10-02 03:37:17.333482+00	17	СОБР-17-Н	2	[{"changed": {"fields": ["\\u041c\\u043e\\u043d\\u0442\\u0430\\u0436\\u043d\\u043e\\u0435 \\u043f\\u043e\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435"]}}]	8	1
216	2024-10-02 03:37:17.33941+00	18	СОБР-17-В	2	[{"changed": {"fields": ["\\u041c\\u043e\\u043d\\u0442\\u0430\\u0436\\u043d\\u043e\\u0435 \\u043f\\u043e\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435"]}}]	8	1
217	2024-10-02 03:37:17.344083+00	19	СОБР-25-Н	2	[{"changed": {"fields": ["\\u041c\\u043e\\u043d\\u0442\\u0430\\u0436\\u043d\\u043e\\u0435 \\u043f\\u043e\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435"]}}]	8	1
218	2024-10-02 03:37:17.349634+00	20	СОБР-25-В	2	[{"changed": {"fields": ["\\u041c\\u043e\\u043d\\u0442\\u0430\\u0436\\u043d\\u043e\\u0435 \\u043f\\u043e\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435"]}}]	8	1
219	2024-10-02 03:37:17.354894+00	102	СОБР-17-Н	2	[{"changed": {"fields": ["\\u041d\\u0430\\u043b\\u0438\\u0447\\u0438\\u0435 \\u0442\\u0435\\u043f\\u043b\\u043e\\u0432\\u043e\\u0433\\u043e \\u0437\\u0430\\u043c\\u043a\\u0430", "\\u041c\\u043e\\u043d\\u0442\\u0430\\u0436\\u043d\\u043e\\u0435 \\u043f\\u043e\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435"]}}]	8	1
220	2024-10-02 03:37:17.359211+00	103	СОБР-17-В	2	[{"changed": {"fields": ["\\u041c\\u043e\\u043d\\u0442\\u0430\\u0436\\u043d\\u043e\\u0435 \\u043f\\u043e\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435"]}}]	8	1
221	2024-10-02 03:37:17.363322+00	104	СОБР-25-Н	2	[{"changed": {"fields": ["\\u041c\\u043e\\u043d\\u0442\\u0430\\u0436\\u043d\\u043e\\u0435 \\u043f\\u043e\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435"]}}]	8	1
222	2024-10-02 03:37:17.367804+00	105	СОБР-25-В	2	[{"changed": {"fields": ["\\u041c\\u043e\\u043d\\u0442\\u0430\\u0436\\u043d\\u043e\\u0435 \\u043f\\u043e\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435"]}}]	8	1
223	2024-10-02 03:40:55.385871+00	15	СВН-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
224	2024-10-02 03:40:55.389402+00	16	СВН-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
225	2024-10-02 03:40:55.400751+00	56	СВН-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
226	2024-10-02 03:40:55.40436+00	58	СВН-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
288	2025-07-06 04:55:02.560427+00	1	Стальные электросварные по ГОСТ 10704 DN 15	1	[{"added": {}}]	10	4
227	2024-10-02 03:40:55.407985+00	59	СВН-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
228	2024-10-02 03:40:55.519729+00	61	СВН-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
229	2024-10-02 03:41:19.723418+00	3	СВВ-10	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
230	2024-10-02 03:41:19.728095+00	4	СВВ-К80	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
231	2024-10-02 03:41:19.731075+00	5	СВВ-12	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
232	2024-10-02 03:41:19.733851+00	6	СВВ-К115	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
233	2024-10-02 03:41:19.736397+00	7	СВВ-15	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
234	2024-10-02 03:41:19.739774+00	8	СВВ-К160	2	[{"changed": {"fields": ["\\u0413\\u0440\\u0443\\u043f\\u043f\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u0439"]}}]	8	1
235	2025-07-04 07:19:25.367564+00	4	None None	1	[{"added": {}}]	7	1
236	2025-07-04 08:14:03.003057+00	1	Узел управления спринклерный прямоточный с устройством задержки	1	[{"added": {}}]	12	4
237	2025-07-04 08:15:44.648014+00	2	Узел управления спринклерный водозаполненный «‎Шалтан»	1	[{"added": {}}]	12	4
238	2025-07-04 08:20:20.492722+00	3	Узел управления спринклерный воздушный  с акселератором	1	[{"added": {}}]	12	4
239	2025-07-04 08:21:00.922953+00	4	Узел управления спринклерный воздушный без акселератора	1	[{"added": {}}]	12	4
240	2025-07-04 08:21:49.780974+00	5	Узел управления «Спринт»	1	[{"added": {}}]	12	4
241	2025-07-04 08:23:08.782537+00	6	Узел управления дренчерный с комбинированным (электро- и гидро) приводом	1	[{"added": {}}]	12	4
242	2025-07-04 08:24:19.472909+00	7	Узел управления дренчерный с пневматическим приводом	1	[{"added": {}}]	12	4
243	2025-07-04 08:25:23.783792+00	8	Узел управления дренчерный с электроприводом «Малорасходный»	1	[{"added": {}}]	12	4
244	2025-07-04 08:53:45.717456+00	1	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04- «Прямоточный 65»)	1	[{"added": {}}]	13	4
245	2025-07-04 08:54:29.188627+00	2	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04- «Прямоточный 80»)	1	[{"added": {}}]	13	4
246	2025-07-04 08:55:23.719863+00	3	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04- «Прямоточный 100»)	1	[{"added": {}}]	13	4
247	2025-07-04 08:55:56.62852+00	4	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04- «Прямоточный 150»)	1	[{"added": {}}]	13	4
248	2025-07-04 08:59:18.343379+00	5	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04- 01-«Прямоточный-65»)	1	[{"added": {}}]	13	4
249	2025-07-04 09:00:23.776307+00	6	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04- 01-«Прямоточный-80»)	1	[{"added": {}}]	13	4
250	2025-07-04 09:00:58.063048+00	7	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04- 01-«Прямоточный-100»)	1	[{"added": {}}]	13	4
251	2025-07-04 09:01:34.101356+00	8	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04- 01-«Прямоточный-150»)	1	[{"added": {}}]	13	4
252	2025-07-04 09:03:01.645914+00	9	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С65/1,6В-ВФ.04- «Шалтан»)	1	[{"added": {}}]	13	4
253	2025-07-04 09:03:21.597179+00	9	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С65/1,6В-ВФ.04- «Шалтан»)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u043e\\u0442\\u0435\\u0440\\u044c \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
254	2025-07-04 09:04:14.764268+00	10	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С80/1,6В-ВФ.04- «Шалтан»)	1	[{"added": {}}]	13	4
255	2025-07-04 09:04:56.049389+00	9	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С65/1,6В-ВФ.04- «Шалтан»)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u043e\\u0442\\u0435\\u0440\\u044c \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
256	2025-07-04 09:05:30.395708+00	9	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С65/1,6В-ВФ.04- «Шалтан»)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u043e\\u0442\\u0435\\u0440\\u044c \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
257	2025-07-04 09:06:18.476493+00	11	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С100/1,6В-ВФ.04- «Шалтан»)	1	[{"added": {}}]	13	4
258	2025-07-04 09:07:00.665508+00	12	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С150/1,6В-ВФ.04- «Шалтан»)	1	[{"added": {}}]	13	4
259	2025-07-04 09:08:04.234553+00	13	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С20/1,6В-ВФ.04- «Шалтан»)	1	[{"added": {}}]	13	4
260	2025-07-04 09:08:15.877331+00	12	Узел управления спринклерный водозаполненный «‎Шалтан» (УУ-С150/1,6В-ВФ.04- «Шалтан»)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u043e\\u0442\\u0435\\u0440\\u044c \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
261	2025-07-04 09:09:48.326022+00	14	Узел управления спринклерный воздушный  с акселератором (УУ-С100/1,6Вз.04-01)	1	[{"added": {}}]	13	4
262	2025-07-04 09:10:13.65882+00	8	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04-01-«Прямоточный-150»)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
263	2025-07-04 09:10:13.668237+00	7	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04-01-«Прямоточный-100»)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
264	2025-07-04 09:10:13.68133+00	6	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04-01-«Прямоточный-80»)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
265	2025-07-04 09:10:13.694682+00	5	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04-01-«Прямоточный-65»)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
266	2025-07-04 09:10:38.192305+00	14	Узел управления спринклерный воздушный  с акселератором (УУ-С100/1,6Вз-ВФ.04-01)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
267	2025-07-04 09:11:27.676072+00	15	Узел управления спринклерный воздушный  с акселератором (УУ-С150/1,6Вз.04-01)	1	[{"added": {}}]	13	4
268	2025-07-04 09:12:02.954002+00	15	Узел управления спринклерный воздушный  с акселератором (УУ-С150/1,6Вз-ВФ.04-01)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
269	2025-07-04 09:12:34.895792+00	4	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04-«Прямоточный 150»)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
270	2025-07-04 09:12:34.903062+00	3	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04-«Прямоточный 100»)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
271	2025-07-04 09:12:34.907001+00	2	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04-«Прямоточный 80»)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
272	2025-07-04 09:12:34.911359+00	1	Узел управления спринклерный прямоточный с устройством задержки (УУ-С65/1,6В-ВФ.04-«Прямоточный 65»)	2	[{"changed": {"fields": ["\\u041e\\u0431\\u043e\\u0437\\u043d\\u0430\\u0447\\u0435\\u043d\\u0438\\u0435 \\u0443\\u0437\\u043b\\u0430 \\u0443\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
273	2025-07-04 09:13:29.72974+00	16	Узел управления спринклерный воздушный без акселератора (УУ-С100/1,6Вз-ВФ.04)	1	[{"added": {}}]	13	4
274	2025-07-04 09:14:26.695505+00	17	Узел управления спринклерный воздушный без акселератора (УУ-С150/1,6Вз-ВФ.04)	1	[{"added": {}}]	13	4
275	2025-07-04 09:16:32.870301+00	18	Узел управления «Спринт» (УУ-С100/1,6Вз(Э220)-ВФ.04 -«Спринт»)	1	[{"added": {}}]	13	4
276	2025-07-04 09:17:08.670948+00	19	Узел управления «Спринт» (УУ-С150/1,6Вз(Э220)-ВФ.04 -«Спринт»)	1	[{"added": {}}]	13	4
277	2025-07-04 09:17:19.555601+00	19	Узел управления «Спринт» (УУ-С150/1,6Вз(Э220)-ВФ.04 -«Спринт»)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u043e\\u0442\\u0435\\u0440\\u044c \\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f"]}}]	13	4
278	2025-07-04 09:18:59.424073+00	20	Узел управления дренчерный с комбинированным (электро- и гидро) приводом (УУ-Д100/1,6(Э24,ГО,07)-ВФ,04)	1	[{"added": {}}]	13	4
279	2025-07-04 09:19:47.999455+00	21	Узел управления дренчерный с комбинированным (электро- и гидро) приводом (УУ-Д150/1,6(Э24,ГО,07)-ВФ,04)	1	[{"added": {}}]	13	4
280	2025-07-04 09:20:50.130703+00	22	Узел управления дренчерный с пневматическим приводом (УУ-Д100/1,6(ПО,028)-ВФ,04)	1	[{"added": {}}]	13	4
281	2025-07-04 09:21:23.707149+00	23	Узел управления дренчерный с пневматическим приводом (УУ-Д150/1,6(ПО,028)-ВФ,04)	1	[{"added": {}}]	13	4
282	2025-07-04 09:23:53.921518+00	24	Узел управления дренчерный с электроприводом «Малорасходный» (УУ-Д25/1,2(Э24)-ГМ.04-«Малорасходный»)	1	[{"added": {}}]	13	4
283	2025-07-04 09:24:45.319447+00	25	Узел управления дренчерный с электроприводом «Малорасходный» (УУ-Д32/1,2(Э24)-ГМ.04-«Малорасходный»)	1	[{"added": {}}]	13	4
284	2025-07-04 09:27:09.365874+00	26	Узел управления дренчерный с электроприводом «Малорасходный» (УУ-Д40/1,2(Э24)-ГМ.04-«Малорасходный»)	1	[{"added": {}}]	13	4
285	2025-07-04 09:27:45.637298+00	27	Узел управления дренчерный с электроприводом «Малорасходный» (УУ-Д50/1,2(Э24)-ГМ.04-«Малорасходный»)	1	[{"added": {}}]	13	4
286	2025-07-06 04:54:00.155685+00	1	Стальные электросварные по ГОСТ 10704	1	[{"added": {}}]	11	4
290	2025-07-06 04:55:48.616812+00	3	Стальные электросварные по ГОСТ 10704 DN 25	1	[{"added": {}}]	10	4
291	2025-07-06 04:56:43.697818+00	4	Стальные электросварные по ГОСТ 10704 DN 32	1	[{"added": {}}]	10	4
292	2025-07-06 04:57:07.580164+00	5	Стальные электросварные по ГОСТ 10704 DN 40	1	[{"added": {}}]	10	4
293	2025-07-06 04:57:44.297756+00	6	Стальные электросварные по ГОСТ 10704 DN 50	1	[{"added": {}}]	10	4
294	2025-07-06 04:58:11.620026+00	7	Стальные электросварные по ГОСТ 10704 DN 65	1	[{"added": {}}]	10	4
295	2025-07-06 04:58:39.173714+00	8	Стальные электросварные по ГОСТ 10704 DN 80	1	[{"added": {}}]	10	4
296	2025-07-06 04:59:16.34559+00	9	Стальные электросварные по ГОСТ 10704 DN 100	1	[{"added": {}}]	10	4
297	2025-07-06 04:59:37.557871+00	10	Стальные электросварные по ГОСТ 10704 DN 100	1	[{"added": {}}]	10	4
298	2025-07-06 05:00:07.074007+00	11	Стальные электросварные по ГОСТ 10704 DN 100	1	[{"added": {}}]	10	4
299	2025-07-06 05:00:40.433181+00	12	Стальные электросварные по ГОСТ 10704 DN 125	1	[{"added": {}}]	10	4
300	2025-07-06 05:01:02.176025+00	13	Стальные электросварные по ГОСТ 10704 DN 125	1	[{"added": {}}]	10	4
301	2025-07-06 05:01:29.353159+00	14	Стальные электросварные по ГОСТ 10704 DN 150	1	[{"added": {}}]	10	4
302	2025-07-06 05:01:55.816425+00	15	Стальные электросварные по ГОСТ 10704 DN 150	1	[{"added": {}}]	10	4
303	2025-07-06 05:02:18.255216+00	16	Стальные электросварные по ГОСТ 10704 DN 200	1	[{"added": {}}]	10	4
304	2025-07-06 05:02:50.248988+00	17	Стальные электросварные по ГОСТ 10704 DN 250	1	[{"added": {}}]	10	4
305	2025-07-06 05:03:12.998805+00	18	Стальные электросварные по ГОСТ 10704 DN 300	1	[{"added": {}}]	10	4
306	2025-07-06 05:03:33.191393+00	19	Стальные электросварные по ГОСТ 10704 DN 350	1	[{"added": {}}]	10	4
307	2025-07-06 05:05:54.167036+00	20	Стальные водогазопроводные по ГОСТ 3262 DN 15	1	[{"added": {}}]	10	4
308	2025-07-06 05:06:16.517084+00	21	Стальные водогазопроводные по ГОСТ 3262 DN 20	1	[{"added": {}}]	10	4
309	2025-07-06 05:06:31.844057+00	22	Стальные водогазопроводные по ГОСТ 3262 DN 25	1	[{"added": {}}]	10	4
310	2025-07-06 05:06:52.1421+00	23	Стальные водогазопроводные по ГОСТ 3262 DN 32	1	[{"added": {}}]	10	4
311	2025-07-06 05:07:10.322368+00	24	Стальные водогазопроводные по ГОСТ 3262 DN 40	1	[{"added": {}}]	10	4
312	2025-07-06 05:07:24.787298+00	25	Стальные водогазопроводные по ГОСТ 3262 DN 50	1	[{"added": {}}]	10	4
313	2025-07-06 05:07:41.704878+00	26	Стальные водогазопроводные по ГОСТ 3262 DN 65	1	[{"added": {}}]	10	4
314	2025-07-06 05:08:05.97399+00	27	Стальные водогазопроводные по ГОСТ 3262 DN 80	1	[{"added": {}}]	10	4
315	2025-07-06 05:08:35.839334+00	28	Стальные водогазопроводные по ГОСТ 3262 DN 90	1	[{"added": {}}]	10	4
316	2025-07-06 05:08:51.784641+00	29	Стальные водогазопроводные по ГОСТ 3262 DN 100	1	[{"added": {}}]	10	4
317	2025-07-06 05:09:10.25405+00	30	Стальные водогазопроводные по ГОСТ 3262 DN 125	1	[{"added": {}}]	10	4
318	2025-07-06 05:09:25.443653+00	31	Стальные водогазопроводные по ГОСТ 3262 DN 150	1	[{"added": {}}]	10	4
319	2025-07-16 09:34:18.080109+00	3	СВВ-10	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
320	2025-07-16 09:34:49.366311+00	4	СВВ-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
321	2025-07-16 09:36:01.100632+00	5	СВВ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
322	2025-07-16 09:36:25.049157+00	6	СВВ-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
323	2025-07-16 09:36:50.120264+00	7	СВВ-15	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
324	2025-07-16 09:37:12.204202+00	8	СВВ-К160	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
325	2025-07-16 09:37:43.897497+00	11	СВК-10	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
326	2025-07-16 09:38:02.180365+00	12	СВК-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
327	2025-07-16 09:43:09.286957+00	14	СВК-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
328	2025-07-16 09:43:30.065774+00	15	СВН-15	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
329	2025-07-16 09:43:49.590339+00	16	СВН-К160	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
330	2025-07-16 09:44:09.050046+00	17	СОБР-17-Н	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
331	2025-07-16 09:44:25.883242+00	18	СОБР-17-В	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
332	2025-07-16 09:44:48.240296+00	19	СОБР-25-Н	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
333	2025-07-16 09:45:01.086712+00	20	СОБР-25-В	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
334	2025-07-16 09:45:46.652805+00	22	СУУ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
335	2025-07-16 09:46:06.388963+00	23	СУУ-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
336	2025-07-16 09:46:27.695638+00	24	СУУ-15	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
337	2025-07-16 09:46:47.815938+00	25	СУУ-К160	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
338	2025-07-16 09:47:58.320521+00	27	СВУ-К57	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
339	2025-07-16 09:48:16.275145+00	28	СВУ-10	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
340	2025-07-16 09:49:18.035343+00	29	SSU-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
341	2025-07-16 09:49:57.60741+00	30	SSP-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
342	2025-07-16 09:51:28.555539+00	31	SSU-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
343	2025-07-16 09:51:47.24801+00	32	SSP-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
344	2025-07-16 09:51:56.094346+00	34	SSP-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
345	2025-07-16 09:52:21.993972+00	35	ОЭ-16	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
346	2025-07-16 09:52:41.177827+00	36	ОЭ-25	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
347	2025-07-16 09:52:52.143867+00	37	ОЦ-9	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
348	2025-07-16 09:53:06.059882+00	38	ОЦ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
349	2025-07-16 09:53:37.862388+00	39	СУВ-К200	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
350	2025-07-16 09:53:54.679821+00	40	СУН-К200	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
351	2025-07-16 09:54:25.902047+00	41	ССН-12 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
352	2025-07-16 09:55:16.426402+00	41	ССН-12 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
353	2025-07-16 09:55:28.71145+00	42	ССН-15 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
354	2025-07-16 09:55:45.111772+00	43	ССВ-12 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
355	2025-07-16 09:56:02.543596+00	44	ССВ-15 (S=3.0 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
356	2025-07-16 09:56:27.750844+00	47	ДВВ-10	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
357	2025-07-16 09:56:45.268619+00	48	ДВВ-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
358	2025-07-16 09:57:03.981879+00	49	ДВВ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
359	2025-07-16 09:57:20.972759+00	50	ДВВ-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
360	2025-07-16 09:57:35.079416+00	51	ДВВ-15	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
361	2025-07-16 09:57:52.44192+00	52	ДВВ-К160	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
362	2025-07-16 09:58:28.12465+00	55	ДВН-10	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
363	2025-07-16 09:58:45.370535+00	56	СВН-10	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
364	2025-07-16 09:59:03.043084+00	57	ДВН-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
365	2025-07-16 10:08:43.032627+00	58	СВН-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
366	2025-07-16 10:08:58.308012+00	59	СВН-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
367	2025-07-16 10:09:19.401829+00	60	ДВН-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
368	2025-07-16 10:09:38.991275+00	61	СВН-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
369	2025-07-16 10:10:09.467472+00	62	ДВН-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
370	2025-07-16 10:10:24.981328+00	63	ДВН-15	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
371	2025-07-16 10:10:42.014+00	64	ДВН-К160	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
372	2025-07-16 10:11:05.981087+00	65	ДУУ-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
373	2025-07-16 10:11:23.86882+00	66	ДУУ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
374	2025-07-16 10:11:47.015623+00	67	ДУУ-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
375	2025-07-16 10:12:11.107567+00	68	ДУУ-15	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
376	2025-07-16 10:12:31.816388+00	69	ДУУ-К160	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
377	2025-07-16 10:12:47.976195+00	70	ДУУ-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
378	2025-07-16 10:13:18.069075+00	71	ДУУ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
379	2025-07-16 10:13:33.809181+00	72	ДУУ-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
380	2025-07-16 10:13:49.584889+00	73	ДУУ-15	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
381	2025-07-16 10:14:06.32208+00	74	ДУУ-К160	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
382	2025-07-16 10:14:20.815079+00	75	ДВУ-8	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
383	2025-07-16 10:14:40.985654+00	76	ДВУ-К57	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
384	2025-07-16 10:14:57.382495+00	77	ДВУ-10	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
385	2025-07-16 10:15:57.84259+00	78	SU-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
386	2025-07-16 10:16:20.296078+00	79	SU-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
387	2025-07-16 10:16:34.319518+00	80	SSU-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
388	2025-07-16 10:16:44.36465+00	81	SP-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
389	2025-07-16 10:17:15.266422+00	83	SU-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
390	2025-07-16 10:17:31.313317+00	84	SSU-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
391	2025-07-16 10:17:47.59619+00	85	SU-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
392	2025-07-16 10:18:05.653682+00	86	SP-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
393	2025-07-16 10:18:25.782958+00	87	SP-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
394	2025-07-16 10:18:55.437756+00	88	ОЭ-16	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
395	2025-07-16 10:19:07.951124+00	89	ОЭ-25	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
396	2025-07-16 10:19:24.571185+00	90	ОЦ-9	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
397	2025-07-16 10:19:40.273987+00	91	ОЦ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
398	2025-07-16 10:20:11.522163+00	92	ДУВ-К200	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
399	2025-07-16 10:20:20.31652+00	93	ДУВ-К200	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
400	2025-07-16 10:20:44.751169+00	94	CУВ-К200	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
401	2025-07-16 10:20:57.854493+00	95	СУН-К200	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
402	2025-07-16 10:21:10.00388+00	96	ДУН-К200	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
403	2025-07-16 10:21:39.052684+00	97	ДУН-К200	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
404	2025-07-16 10:22:04.134511+00	98	СУУ-К115	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
405	2025-07-16 10:22:25.459351+00	99	SP-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
406	2025-07-16 10:22:39.585859+00	100	SSP-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
407	2025-07-16 10:22:56.5329+00	102	СОБР-17-Н	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
408	2025-07-16 10:23:07.692991+00	103	СОБР-17-В	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
409	2025-07-16 10:23:17.852207+00	104	СОБР-25-Н	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
410	2025-07-16 10:23:26.900384+00	105	СОБР-25-В	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
411	2025-07-16 10:23:41.238376+00	106	СУУ-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
412	2025-07-16 10:23:58.34914+00	107	СУУ-15	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
413	2025-07-16 10:24:10.566297+00	108	СУУ-К160	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
414	2025-07-16 10:24:24.31808+00	109	СУУ-12	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
415	2025-07-16 10:24:51.179628+00	112	ССН-12 (S=3.0 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
416	2025-07-16 10:25:00.737333+00	113	ССН-15 (S=3.0 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
417	2025-07-16 10:25:30.46928+00	114	ССВ-15 (S=5.3 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
418	2025-07-16 10:25:40.734784+00	115	ССВ-12 (S=3.0 м²)	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
419	2025-07-16 10:27:15.963085+00	21	СУУ-К80	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
420	2025-07-16 10:27:36.47568+00	26	СВУ-8	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
421	2025-07-16 10:29:41.018264+00	3	СВВ-10	2	[{"changed": {"fields": ["\\u041a\\u043e\\u044d\\u0444\\u0444\\u0438\\u0446\\u0438\\u0435\\u043d\\u0442 \\u043f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u0438"]}}]	8	4
422	2025-12-17 02:13:55.848865+00	27	Узел управления дренчерный с электроприводом «Малорасходный» (УУ-Д50/1,2(Э24)-ГМ.04-«Малорасходный»)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
423	2025-12-17 02:13:55.871889+00	26	Узел управления дренчерный с электроприводом «Малорасходный» (УУ-Д40/1,2(Э24)-ГМ.04-«Малорасходный»)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
424	2025-12-17 02:13:55.878209+00	25	Узел управления дренчерный с электроприводом «Малорасходный» (УУ-Д32/1,2(Э24)-ГМ.04-«Малорасходный»)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
425	2025-12-17 02:13:55.882832+00	24	Узел управления дренчерный с электроприводом «Малорасходный» (УУ-Д25/1,2(Э24)-ГМ.04-«Малорасходный»)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
426	2025-12-17 02:13:55.888983+00	23	Узел управления дренчерный с пневматическим приводом (УУ-Д150/1,6(ПО,028)-ВФ,04)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
427	2025-12-17 02:13:55.895192+00	22	Узел управления дренчерный с пневматическим приводом (УУ-Д100/1,6(ПО,028)-ВФ,04)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
428	2025-12-17 02:13:55.904323+00	21	Узел управления дренчерный с комбинированным (электро- и гидро) приводом (УУ-Д150/1,6(Э24,ГО,07)-ВФ,04)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
429	2025-12-17 02:13:55.908007+00	20	Узел управления дренчерный с комбинированным (электро- и гидро) приводом (УУ-Д100/1,6(Э24,ГО,07)-ВФ,04)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
430	2025-12-17 02:13:55.911555+00	19	Узел управления «Спринт» (УУ-С150/1,6Вз(Э220)-ВФ.04 -«Спринт»)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
431	2025-12-17 02:13:55.915915+00	18	Узел управления «Спринт» (УУ-С100/1,6Вз(Э220)-ВФ.04 -«Спринт»)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
432	2025-12-17 02:13:55.921334+00	17	Узел управления спринклерный воздушный без акселератора (УУ-С150/1,6Вз-ВФ.04)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
433	2025-12-17 02:13:55.931998+00	16	Узел управления спринклерный воздушный без акселератора (УУ-С100/1,6Вз-ВФ.04)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
434	2025-12-17 02:13:55.937438+00	15	Узел управления спринклерный воздушный  с акселератором (УУ-С150/1,6Вз-ВФ.04-01)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
435	2025-12-17 02:13:55.943302+00	14	Узел управления спринклерный воздушный  с акселератором (УУ-С100/1,6Вз-ВФ.04-01)	2	[{"changed": {"fields": ["\\u0422\\u0438\\u043f \\u0443\\u0441\\u0442\\u0430\\u043d\\u043e\\u0432\\u043a\\u0438"]}}]	13	4
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	users	usergroup
7	users	user
8	sprinkler	sprinkler
9	main	seosettings
10	tubes	type
11	tubes	tubetype
12	management_node	controlunitname
13	management_node	controlunit
14	users	calculateresult
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-08-06 05:01:14.649035+00
2	contenttypes	0002_remove_content_type_name	2024-08-06 05:01:14.743064+00
3	auth	0001_initial	2024-08-06 05:01:14.87162+00
4	auth	0002_alter_permission_name_max_length	2024-08-06 05:01:14.878123+00
5	auth	0003_alter_user_email_max_length	2024-08-06 05:01:14.883479+00
6	auth	0004_alter_user_username_opts	2024-08-06 05:01:14.888824+00
7	auth	0005_alter_user_last_login_null	2024-08-06 05:01:14.893984+00
8	auth	0006_require_contenttypes_0002	2024-08-06 05:01:14.896656+00
9	auth	0007_alter_validators_add_error_messages	2024-08-06 05:01:14.902146+00
10	auth	0008_alter_user_username_max_length	2024-08-06 05:01:14.907507+00
11	auth	0009_alter_user_last_name_max_length	2024-08-06 05:01:14.912461+00
12	auth	0010_alter_group_name_max_length	2024-08-06 05:01:14.954118+00
13	auth	0011_update_proxy_permissions	2024-08-06 05:01:14.959391+00
14	auth	0012_alter_user_first_name_max_length	2024-08-06 05:01:14.964901+00
15	users	0001_initial	2024-08-06 05:01:15.134756+00
16	admin	0001_initial	2024-08-06 05:01:15.202501+00
17	admin	0002_logentry_remove_auto_add	2024-08-06 05:01:15.210951+00
18	admin	0003_logentry_add_action_flag_choices	2024-08-06 05:01:15.219702+00
19	sessions	0001_initial	2024-08-06 05:01:15.268577+00
20	sprinkler	0001_initial	2024-08-06 05:01:15.319702+00
21	sprinkler	0002_sprinkler_pmax_sprinkler_pmin_sprinkler_k0_and_more	2024-08-06 05:01:15.345997+00
22	sprinkler	0003_alter_sprinkler_options_sprinkler_otv_type	2024-08-09 00:56:06.005973+00
23	sprinkler	0004_sprinkler_intensity_pmax_sprinkler_intensity_pmin_and_more	2024-08-25 10:54:07.924938+00
24	sprinkler	0005_sprinkler_groups	2024-08-25 12:15:08.350374+00
25	sprinkler	0006_sprinkler_s	2024-10-01 07:00:45.500603+00
26	sprinkler	0007_sprinkler_thermal_lock	2024-10-01 07:00:46.630421+00
27	sprinkler	0008_sprinkler_mounting_position	2024-10-01 07:00:46.84285+00
28	sprinkler	0009_auto_20240922_2020	2024-10-01 07:00:46.989295+00
29	sprinkler	0010_alter_sprinkler_k0_alter_sprinkler_k1_and_more	2024-10-02 03:23:38.238853+00
30	main	0001_initial	2025-06-30 02:39:42.261305+00
31	management_node	0001_initial	2025-07-04 07:17:12.714695+00
32	tubes	0001_initial	2025-07-04 07:17:12.755574+00
33	management_node	0002_remove_controlunit_dn_alter_controlunit_diameter	2025-07-04 08:10:57.905665+00
34	management_node	0003_alter_controlunit_pressure_loss	2025-07-04 08:52:58.285658+00
35	management_node	0004_alter_controlunit_pressure_loss	2025-07-04 08:52:58.471691+00
36	management_node	0005_alter_controlunit_pressure_loss	2025-07-04 08:52:58.484055+00
37	sprinkler	0011_sprinkler_k	2025-07-16 09:31:14.494393+00
38	management_node	0006_controlunit_installation_type	2025-12-17 02:12:39.636143+00
39	users	0002_calculateresults	2025-12-17 08:19:02.124792+00
40	users	0003_rename_calculateresults_calculateresult	2025-12-17 08:19:02.173386+00
41	users	0004_alter_calculateresult_data	2025-12-17 08:19:02.181602+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
1q2ku16pgxutq9s4xykv4f9hnyk9xchq	.eJxVjMsOwiAQRf-FtSFSHgMu3fcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mL0OL0uyXMD247oDu22yzz3NZlSnJX5EG7HGfi5_Vw_w4q9vqtnbOoUmKTAVPwpmgGoyzprLAkUmcFxtkhAwcsQMYF7X2mYAeEgqaI9wfxFDhC:1scFZo:nkVA3d0iclArIl4FpP7hDUoBNmSuSz7zaf1Oab_qSmI	2024-08-23 02:42:00.742692+00
nbz1hhbaz0uuzhsbu53osam649saw1bg	.eJxVjMsOwiAQRf-FtSFSHgMu3fcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mL0OL0uyXMD247oDu22yzz3NZlSnJX5EG7HGfi5_Vw_w4q9vqtnbOoUmKTAVPwpmgGoyzprLAkUmcFxtkhAwcsQMYF7X2mYAeEgqaI9wfxFDhC:1scFbN:Aa2KPsaPR67edHftL1cT-Yz-kR1niuordNgr4n38K1U	2024-08-23 02:43:37.991037+00
kgb3wtdpxsyhi73kdwxa5vsrpwia7518	.eJxVjMsOwiAQRf-FtSFSHgMu3fcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mL0OL0uyXMD247oDu22yzz3NZlSnJX5EG7HGfi5_Vw_w4q9vqtnbOoUmKTAVPwpmgGoyzprLAkUmcFxtkhAwcsQMYF7X2mYAeEgqaI9wfxFDhC:1sdlqh:5o3ylyJZegC0GnNqH_cwwrU41GBlK9n3BBmsVD4WgjM	2024-08-27 07:21:43.061105+00
kwste6nwee35hirh80u0uddk5emk71ug	.eJxVjMsOwiAQRf-FtSFSHgMu3fcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mL0OL0uyXMD247oDu22yzz3NZlSnJX5EG7HGfi5_Vw_w4q9vqtnbOoUmKTAVPwpmgGoyzprLAkUmcFxtkhAwcsQMYF7X2mYAeEgqaI9wfxFDhC:1sdm9Z:FsZVwDvmJrCRwDH6tKBsngpAnSPjODwlwz0kdDy5yzo	2024-08-27 07:41:13.693378+00
ekzombalsao2oqj9qpkk3tcnp4fupbpv	.eJxVjMsOwiAQRf-FtSFSHgMu3fcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mL0OL0uyXMD247oDu22yzz3NZlSnJX5EG7HGfi5_Vw_w4q9vqtnbOoUmKTAVPwpmgGoyzprLAkUmcFxtkhAwcsQMYF7X2mYAeEgqaI9wfxFDhC:1seqz3:oKuWU_lLl7-X-Lw2Xn1JbCEwIbLn1jVIkrYwnpsXJpI	2024-08-30 07:02:49.134279+00
age8x8hv96jd3xru7ehdtqv9kbwxkj2s	.eJxVjEEOwiAURO_C2hAofAou3XsGAvyPVA0kpV0Z764kXWgyq3lv5sV82Lfi906rX5CdmWSn3y6G9KA6AN5DvTWeWt3WJfKh8IN2fm1Iz8vh_h2U0MtYAwiZDWJE7SzElHUUaGCyhCCMkS6QdBa1MqCcziZ8M8-klJ4iJGDvD-h0N7Q:1si2wd:_4RXBUYKJ8r3Vyra5RPbnHhxfxrULMOjdaB_bb6RtlU	2024-09-08 02:25:31.68123+00
yy4cn9jre0y984gr1zv95um2htfjchuh	.eJxVjEEOwiAURO_C2hAofAou3XsGAvyPVA0kpV0Z764kXWgyq3lv5sV82Lfi906rX5CdmWSn3y6G9KA6AN5DvTWeWt3WJfKh8IN2fm1Iz8vh_h2U0MtYAwiZDWJE7SzElHUUaGCyhCCMkS6QdBa1MqCcziZ8M8-klJ4iJGDvD-h0N7Q:1siSdA:fAENj7rVdGkjj1E7THL8Gv7MXqSnSsChoq2POOxPv1c	2024-09-09 05:51:08.703466+00
2pghfp2c1tm7i7rfun6lsbu4i56feuzs	.eJxVjMsOwiAQRf-FtSFSHgMu3fcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mL0OL0uyXMD247oDu22yzz3NZlSnJX5EG7HGfi5_Vw_w4q9vqtnbOoUmKTAVPwpmgGoyzprLAkUmcFxtkhAwcsQMYF7X2mYAeEgqaI9wfxFDhC:1siUBG:r8ebXT1SGLq6mWEE4U7kG_GZZZCwm_W1KoZY7oa3cgE	2024-09-09 07:30:26.645693+00
25sog53p5mg2hk5f8rlickexfbuvhbhm	.eJxVjMsOwiAQRf-FtSFSHgMu3fcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mL0OL0uyXMD247oDu22yzz3NZlSnJX5EG7HGfi5_Vw_w4q9vqtnbOoUmKTAVPwpmgGoyzprLAkUmcFxtkhAwcsQMYF7X2mYAeEgqaI9wfxFDhC:1siUOK:1YXS8R21Z7g79PDCfJybiz1wTl-zi2L5S-5xCKneO-Q	2024-09-09 07:43:56.778446+00
h09vp4eotuw9ps07fk61ml4i0rkwqe6o	.eJxVjMsOwiAQRf-FtSFSHgMu3fcbyMAMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJE4mL0OL0uyXMD247oDu22yzz3NZlSnJX5EG7HGfi5_Vw_w4q9vqtnbOoUmKTAVPwpmgGoyzprLAkUmcFxtkhAwcsQMYF7X2mYAeEgqaI9wfxFDhC:1siW4x:xdcABtZebuoo_w7iW1iMBNigM9WT7MUcsBBGkCzLWW4	2024-09-09 09:32:03.679671+00
88lgy28rgli24jpacw8gznx979x638l2	.eJxVjEEOwiAURO_C2hAofAou3XsGAvyPVA0kpV0Z764kXWgyq3lv5sV82Lfi906rX5CdmWSn3y6G9KA6AN5DvTWeWt3WJfKh8IN2fm1Iz8vh_h2U0MtYAwiZDWJE7SzElHUUaGCyhCCMkS6QdBa1MqCcziZ8M8-klJ4iJGDvD-h0N7Q:1svXAv:ZNiAr8vLoBp_M_AFVfSDmhsI-PPOHkJPWUmo0-ukbVY	2024-10-15 07:20:01.331334+00
jwvzqm8dvoav634olh4u0dv7qbvya53w	.eJxVjEEOwiAQRe_C2hDaKQy4dO8ZyFBmpGpoUtqV8e7apAvd_vfef6lI21ri1niJU1ZnNajT75ZofHDdQb5Tvc16nOu6TEnvij5o09c58_NyuH8HhVr51hggDclmYACygozkJDnCzgkYQw6soRA6Q-xRhG3oBbEnCsZ6L6LeH-V8N-k:1uXak7:skEM5tm2sLQEdCZuICvo1V6ELdbeMuEvOLV8L6eLDxQ	2025-07-18 07:21:55.730339+00
no6u84h6ts38w7byuqob1olkn4g067os	.eJxVjEEOwiAQRe_C2hDaKQy4dO8ZyFBmpGpoUtqV8e7apAvd_vfef6lI21ri1niJU1ZnNajT75ZofHDdQb5Tvc16nOu6TEnvij5o09c58_NyuH8HhVr51hggDclmYACygozkJDnCzgkYQw6soRA6Q-xRhG3oBbEnCsZ6L6LeH-V8N-k:1uXakY:XZn362GbUZJddrjJSWDXIMSkMCFdzc5flQXguAzArrQ	2025-07-18 07:22:22.440193+00
c5x5eynyp374v81bgqag6cve6w7yip3m	.eJxVjEEOwiAQRe_C2hDaKQy4dO8ZyFBmpGpoUtqV8e7apAvd_vfef6lI21ri1niJU1ZnNajT75ZofHDdQb5Tvc16nOu6TEnvij5o09c58_NyuH8HhVr51hggDclmYACygozkJDnCzgkYQw6soRA6Q-xRhG3oBbEnCsZ6L6LeH-V8N-k:1vVh2F:ePeNz7SMTuV1JFH3AK_FyTZuqaUhSig7OqNfHclEaOA	2025-12-31 02:13:03.445217+00
\.


--
-- Data for Name: main_seosettings; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.main_seosettings (id, meta_tags, counters) FROM stdin;
1		
\.


--
-- Data for Name: management_node_controlunit; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.management_node_controlunit (id, designation, diameter, pressure_loss, control_unit_name_id, installation_type) FROM stdin;
10	УУ-С80/1,6В-ВФ.04- «Шалтан»	80.0	0.000000529000000	2	sprinkler_water
9	УУ-С65/1,6В-ВФ.04- «Шалтан»	65.0	0.000001527000000	2	sprinkler_water
11	УУ-С100/1,6В-ВФ.04- «Шалтан»	100.0	0.000000201000000	2	sprinkler_water
13	УУ-С20/1,6В-ВФ.04- «Шалтан»	200.0	0.000000013000000	2	sprinkler_water
12	УУ-С150/1,6В-ВФ.04- «Шалтан»	150.0	0.000000039000000	2	sprinkler_water
8	УУ-С65/1,6В-ВФ.04-01-«Прямоточный-150»	150.0	0.000000038580000	1	sprinkler_water
7	УУ-С65/1,6В-ВФ.04-01-«Прямоточный-100»	100.0	0.000000169750000	1	sprinkler_water
6	УУ-С65/1,6В-ВФ.04-01-«Прямоточный-80»	80.0	0.000000176250000	1	sprinkler_water
5	УУ-С65/1,6В-ВФ.04-01-«Прямоточный-65»	65.0	0.000000586420000	1	sprinkler_water
4	УУ-С65/1,6В-ВФ.04-«Прямоточный 150»	150.0	0.000000038580000	1	sprinkler_water
3	УУ-С65/1,6В-ВФ.04-«Прямоточный 100»	100.0	0.000000169750000	1	sprinkler_water
2	УУ-С65/1,6В-ВФ.04-«Прямоточный 80»	80.0	0.000000176250000	1	sprinkler_water
1	УУ-С65/1,6В-ВФ.04-«Прямоточный 65»	65.0	0.000000586420000	1	sprinkler_water
27	УУ-Д50/1,2(Э24)-ГМ.04-«Малорасходный»	50.0	0.000027000000000	8	drench
26	УУ-Д40/1,2(Э24)-ГМ.04-«Малорасходный»	40.0	0.000092600000000	8	drench
25	УУ-Д32/1,2(Э24)-ГМ.04-«Малорасходный»	32.0	0.000169800000000	8	drench
24	УУ-Д25/1,2(Э24)-ГМ.04-«Малорасходный»	25.0	0.000463000000000	8	drench
23	УУ-Д150/1,6(ПО,028)-ВФ,04	150.0	0.000000046270000	7	drench
22	УУ-Д100/1,6(ПО,028)-ВФ,04	100.0	0.000000231480000	7	drench
21	УУ-Д150/1,6(Э24,ГО,07)-ВФ,04	150.0	0.000000046270000	6	drench
20	УУ-Д100/1,6(Э24,ГО,07)-ВФ,04	100.0	0.000000231480000	6	drench
19	УУ-С150/1,6Вз(Э220)-ВФ.04 -«Спринт»	150.0	0.000000046260000	5	sprinkler_air
18	УУ-С100/1,6Вз(Э220)-ВФ.04 -«Спринт»	100.0	0.000000231480000	5	sprinkler_air
17	УУ-С150/1,6Вз-ВФ.04	150.0	0.000000046270000	4	sprinkler_air
16	УУ-С100/1,6Вз-ВФ.04	100.0	0.000000231480000	4	sprinkler_air
15	УУ-С150/1,6Вз-ВФ.04-01	150.0	0.000000046270000	3	sprinkler_air
14	УУ-С100/1,6Вз-ВФ.04-01	100.0	0.000000231480000	3	sprinkler_air
\.


--
-- Data for Name: management_node_controlunitname; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.management_node_controlunitname (id, name) FROM stdin;
1	Узел управления спринклерный прямоточный с устройством задержки
2	Узел управления спринклерный водозаполненный «‎Шалтан»
3	Узел управления спринклерный воздушный  с акселератором
4	Узел управления спринклерный воздушный без акселератора
5	Узел управления «Спринт»
6	Узел управления дренчерный с комбинированным (электро- и гидро) приводом
7	Узел управления дренчерный с пневматическим приводом
8	Узел управления дренчерный с электроприводом «Малорасходный»
\.


--
-- Data for Name: sprinkler_sprinkler; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.sprinkler_sprinkler (id, name, diameter, mu, "Pmax", "Pmin", k0, k1, k2, k3, k4, k5, otv_type, "intensity_Pmax", "intensity_Pmin", groups, "S", thermal_lock, mounting_position, "K") FROM stdin;
41	ССН-12	\N	\N	1.000	0.100	0.2275	0.4050	0.2500	0.0000	0.0000	0.0000	water	0.88250	0.27050	{5,6}	5.3	sprinkler	vertical_down	0.470
56	СВН-10	\N	\N	1.000	0.050	0.0388	0.3073	-0.1043	0.0000	0.0000	0.0000	water	0.24180	0.05390	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_down	0.350
113	ССН-15	\N	\N	1.000	0.100	0.0000	0.0000	0.2469	-0.8084	0.9916	0.3195	water	0.74960	0.00180	{5,6}	3.0	sprinkler	vertical_down	0.800
3	СВВ-10	\N	\N	1.000	0.050	0.0443	0.2881	-0.1118	0.0000	0.0000	0.0000	water	0.22060	0.05840	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_up	0.350
43	ССВ-12	\N	\N	1.000	0.100	0.2075	0.5050	0.2500	0.0000	0.0000	0.0000	water	0.96250	0.26050	{5,6}	5.3	sprinkler	vertical_up	0.470
79	SU-К80	\N	\N	1.600	0.100	0.0432	0.5918	-1.2393	1.3763	-0.7466	0.1551	water	0.18820	0.09130	{1,2,3}	\N	drench	vertical_up	0.420
19	СОБР-25-Н	\N	\N	1.200	0.150	0.3343	2.6841	-1.7371	0.3632	0.0000	0.0000	foam	1.68140	0.69910	{3,4.1,4.2,5,6}	\N		vertical_down	1.910
17	СОБР-17-Н	\N	\N	1.200	0.150	0.2217	1.8789	-1.0973	0.2112	0.0000	0.0000	foam	1.26120	0.47960	{3,4.1,4.2,5,6}	\N		vertical_down	1.280
7	СВВ-15	\N	\N	1.000	0.050	0.0898	0.6313	-0.4705	0.1394	0.0000	0.0000	water	0.39000	0.12020	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_up	0.770
8	СВВ-К160	\N	\N	1.000	0.050	0.1005	0.6217	-0.4451	0.1127	0.0000	0.0000	water	0.38980	0.13050	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_up	0.840
21	СУУ-К80	\N	\N	1.000	0.050	-0.0343	1.2646	-3.8818	6.1108	-4.6728	1.3725	foam	0.15900	0.02000	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.420
22	СУУ-12	\N	\N	1.000	0.050	-0.0101	1.2079	-3.5182	5.4094	-4.0163	1.1363	water	0.20900	0.04220	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.470
13	СВК-12	\N	\N	1.000	0.050	0.0600	0.3447	-0.1376	0.0000	0.0000	0.0000	water	0.26710	0.07690	{1,2}	\N	sprinkler	vertical_down	\N
23	СУУ-К115	\N	\N	1.000	0.050	-0.0008	1.2568	-3.3921	4.8202	-3.3634	0.9082	water	0.22890	0.05410	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.600
18	СОБР-17-В	\N	\N	1.200	0.100	0.2282	1.9797	-1.3801	0.3366	0.0000	0.0000	foam	1.19810	0.41270	{3,4.1,4.2,5,6}	\N		vertical_up	1.280
20	СОБР-25-В	\N	\N	1.200	0.150	0.3564	2.5773	-1.5944	0.2944	0.0000	0.0000	foam	1.66190	0.70810	{3,4.1,4.2,5,6}	\N		vertical_up	1.910
11	СВК-10	\N	\N	1.000	0.050	0.0388	0.3073	-0.1043	0.0000	0.0000	0.0000	water	0.24180	0.05390	{1,2}	\N	sprinkler	vertical_down	0.350
12	СВК-К80	\N	\N	1.000	0.050	0.0464	0.3257	-0.1209	0.0000	0.0000	0.0000	water	0.25120	0.06240	{1,2}	\N	sprinkler	vertical_down	0.420
14	СВК-К115	\N	\N	1.000	0.050	0.0679	0.3557	-0.1349	0.0000	0.0000	0.0000	water	0.28870	0.08530	{1,2}	\N	sprinkler	vertical_down	0.600
4	СВВ-К80	\N	\N	1.000	0.050	0.0479	0.3097	-0.1171	0.0000	0.0000	0.0000	water	0.24050	0.06310	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_up	0.420
5	СВВ-12	\N	\N	1.000	0.050	0.0663	0.3099	-0.1279	0.0000	0.0000	0.0000	water	0.24830	0.08150	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_up	0.470
6	СВВ-К115	\N	\N	1.000	0.050	0.0679	0.3557	-0.1349	0.0000	0.0000	0.0000	water	0.28870	0.08530	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_up	0.600
15	СВН-15	\N	\N	1.000	0.050	0.0839	0.5429	-0.3916	0.1144	0.0000	0.0000	water	0.34960	0.11010	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_down	0.770
16	СВН-К160	\N	\N	1.000	0.050	0.0988	0.6238	-0.4823	0.1395	0.0000	0.0000	water	0.37980	0.12880	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_down	0.840
24	СУУ-15	\N	\N	1.000	0.050	0.1156	0.7500	-1.6924	1.7640	-0.6772	0.0000	foam	0.26000	0.14910	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.770
25	СУУ-К160	\N	\N	1.000	0.150	0.1461	0.5939	-1.2693	1.2788	-0.4795	0.0000	foam	0.27000	0.21070	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.840
27	СВУ-К57	\N	\N	1.000	0.050	-0.0110	0.7267	-1.8971	2.7266	-1.9395	0.5339	water	0.13960	0.02090	{1,2,3}	\N	sprinkler	vertical_down	0.300
28	СВУ-10	\N	\N	1.000	0.050	-0.0081	0.8244	-2.0685	2.8744	-1.9816	0.5290	water	0.16960	0.02830	{1,2,3}	\N	sprinkler	vertical_down	0.350
29	SSU-К80	\N	\N	1.600	0.150	0.0206	0.8910	-1.8874	2.0458	-1.0779	0.2182	foam	0.21790	0.11820	{1,2,3}	\N	sprinkler	vertical_up	0.420
30	SSP-К80	\N	\N	1.600	0.100	0.0147	0.5737	-1.1843	1.2757	-0.6751	0.1379	water	0.14770	0.06140	{1,2,3}	\N	sprinkler	vertical_down	0.420
31	SSU-К115	\N	\N	1.600	0.150	0.0021	1.3894	-3.1633	3.5809	-1.9378	0.3989	foam	0.27770	0.15050	{1,2,3}	\N	sprinkler	vertical_up	0.600
32	SSP-К115	\N	\N	1.600	0.100	0.0279	0.7763	-1.5903	1.6875	-0.8770	0.1760	water	0.20880	0.09120	{1,2,3}	\N	sprinkler	vertical_down	0.600
34	SSP-К115	\N	\N	1.600	0.150	-0.0238	1.4005	-3.1885	3.5833	-1.9247	0.3939	foam	0.24830	0.12570	{1,2,3}	\N	sprinkler	vertical_down	0.600
35	ОЭ-16	\N	\N	1.000	0.150	0.0301	0.3766	-0.2154	0.0591	0.0000	0.0000	water	0.25040	0.08190	{2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.280
36	ОЭ-25	\N	\N	1.000	0.150	0.1257	0.9508	-0.7681	0.2819	0.0000	0.0000	water	0.59030	0.25200	{2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.850
37	ОЦ-9	\N	\N	1.600	0.100	0.0112	0.1563	-0.0986	0.0235	0.0000	0.0000	water	0.10510	0.02590	{2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.130
38	ОЦ-12	\N	\N	1.600	0.100	0.0325	0.1977	-0.1440	0.0364	0.0000	0.0000	water	0.12930	0.05090	{2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.160
39	СУВ-К200	\N	\N	1.000	0.050	0.0691	1.2164	-0.9229	0.2480	0.0000	0.0000	water	0.61060	0.12760	{3,4.1,4.2,5,6}	\N	sprinkler	vertical_up	1.050
40	СУН-К200	\N	\N	1.000	0.050	0.0857	1.2360	-0.9033	0.2216	0.0000	0.0000	water	0.64000	0.14530	{3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	1.050
114	ССВ-15	\N	\N	1.000	0.100	0.3287	0.3625	0.2950	0.7500	0.0000	0.0000	water	1.73620	0.36860	{5,6}	5.3	sprinkler	vertical_up	0.800
26	СВУ-8	\N	\N	1.000	0.050	-0.0214	0.6750	-1.8414	2.7990	-2.0918	0.6001	water	0.11950	0.00810	{1,2,3}	\N	sprinkler	vertical_down	0.240
44	ССВ-15	\N	\N	1.000	0.100	0.3287	1.1073	-0.8614	0.2657	0.0000	0.0000	water	0.84030	0.43110	{5,6}	3.0	sprinkler	vertical_up	0.800
47	ДВВ-10	\N	\N	1.000	0.050	0.0443	0.2881	-0.1118	0.0000	0.0000	0.0000	water	0.22060	0.05840	{1,2,3}	\N	drench	vertical_up	0.350
57	ДВН-К80	\N	\N	1.000	0.050	0.0464	0.3257	-0.1209	0.0000	0.0000	0.0000	water	0.25120	0.06240	{1,2,3}	\N	drench	vertical_down	0.420
59	СВН-12	\N	\N	1.000	0.050	0.0600	0.3447	-0.1376	0.0000	0.0000	0.0000	water	0.26710	0.07690	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_down	0.470
60	ДВН-12	\N	\N	1.000	0.050	0.0600	0.3447	-0.1376	0.0000	0.0000	0.0000	water	0.26710	0.07690	{1,2,3}	\N	drench	vertical_down	0.470
62	ДВН-К115	\N	\N	1.000	0.050	0.0679	0.3557	-0.1349	0.0000	0.0000	0.0000	water	0.28870	0.08530	{1,2,3}	\N	drench	vertical_down	0.600
42	ССН-15	\N	\N	1.000	0.100	0.3625	0.2950	0.7500	0.0000	0.0000	0.0000	water	1.40750	0.39950	{5,6}	5.3	sprinkler	vertical_down	0.800
48	ДВВ-К80	\N	\N	1.000	0.050	0.0479	0.3097	-0.1171	0.0000	0.0000	0.0000	water	0.24050	0.06310	{1,2,3}	\N	drench	vertical_up	0.420
49	ДВВ-12	\N	\N	1.000	0.050	0.0663	0.3099	-0.1279	0.0000	0.0000	0.0000	water	0.24830	0.08150	{1,2,3}	\N	drench	vertical_up	0.470
50	ДВВ-К115	\N	\N	1.000	0.050	0.0679	0.3557	-0.1349	0.0000	0.0000	0.0000	water	0.28870	0.08530	{1,2,3}	\N	drench	vertical_up	0.600
51	ДВВ-15	\N	\N	1.000	0.050	0.0898	0.6313	-0.4705	0.1394	0.0000	0.0000	water	0.39000	0.12020	{1,2,3}	\N	drench	vertical_up	0.770
52	ДВВ-К160	\N	\N	1.000	0.050	0.1005	0.6217	-0.4451	0.1127	0.0000	0.0000	water	0.38980	0.13050	{1,2,3}	\N	drench	vertical_up	0.840
55	ДВН-10	\N	\N	1.000	0.050	0.0388	0.3073	-0.1043	0.0000	0.0000	0.0000	water	0.24180	0.05390	{1,2,3}	\N	drench	vertical_down	0.350
58	СВН-К80	\N	\N	1.000	0.050	0.0464	0.3257	-0.1209	0.0000	0.0000	0.0000	water	0.25120	0.06240	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_down	0.420
61	СВН-К115	\N	\N	1.000	0.050	0.0679	0.3557	-0.1349	0.0000	0.0000	0.0000	water	0.28870	0.08530	{1,2,3,4.1,5,6}	\N	sprinkler	vertical_down	0.600
63	ДВН-15	\N	\N	1.000	0.050	0.0839	0.5429	-0.3916	0.1144	0.0000	0.0000	water	0.34960	0.11010	{1,2,3}	\N	drench	vertical_down	0.770
64	ДВН-К160	\N	\N	1.000	0.050	0.0988	0.6238	-0.4823	0.1395	0.0000	0.0000	water	0.37980	0.12880	{1,2,3}	\N	drench	vertical_down	0.840
65	ДУУ-К80	\N	\N	1.000	0.050	-0.0343	1.2646	-3.8818	6.1108	-4.6728	1.3725	foam	0.15900	0.02000	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.420
66	ДУУ-12	\N	\N	1.000	0.050	-0.0101	1.2079	-3.5182	5.4094	-4.0163	1.1363	water	0.20900	0.04220	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.470
67	ДУУ-К115	\N	\N	1.000	0.150	-0.0169	1.6773	-5.2109	8.1650	-6.1812	1.7957	foam	0.22900	0.14200	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.600
68	ДУУ-15	\N	\N	1.000	0.150	0.1156	0.7500	-1.6924	1.7640	-0.6772	0.0000	foam	0.26000	0.19560	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.770
69	ДУУ-К160	\N	\N	1.000	0.050	0.0042	1.9212	-5.9184	9.2800	-7.0370	2.0437	water	0.29370	0.08660	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.840
70	ДУУ-К80	\N	\N	1.000	0.050	-0.0131	1.0322	-2.8626	4.2927	-3.1334	0.8734	water	0.18920	0.03190	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.420
71	ДУУ-12	\N	\N	1.000	0.150	-0.0076	1.2957	-3.9449	6.0796	-4.5569	1.3174	foam	0.18330	0.11630	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.470
72	ДУУ-К115	\N	\N	1.000	0.050	-0.0008	1.2568	-3.3921	4.8202	-3.3634	0.9082	water	0.22890	0.05410	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.600
73	ДУУ-15	\N	\N	1.000	0.050	-0.0006	1.7027	-5.1591	7.9720	-5.9275	1.6816	water	0.26910	0.07260	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.770
74	ДУУ-К160	\N	\N	1.000	0.150	0.1461	0.5939	-1.2693	1.2788	-0.4795	0.0000	foam	0.27000	0.21070	{1,2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.840
75	ДВУ-8	\N	\N	1.000	0.050	-0.0214	0.6750	-1.8414	2.7990	-2.0918	0.6001	water	0.11950	0.00810	{1,2,3}	\N	drench	vertical_down	0.240
76	ДВУ-К57	\N	\N	1.000	0.050	-0.0110	0.7267	-1.8971	2.7266	-1.9395	0.5339	water	0.13960	0.02090	{1,2,3}	\N	drench	vertical_down	0.300
77	ДВУ-10	\N	\N	1.000	0.050	-0.0081	0.8244	-2.0685	2.8744	-1.9816	0.5290	water	0.16960	0.02830	{1,2,3}	\N	drench	vertical_down	0.350
78	SU-К80	\N	\N	1.600	0.150	0.0206	0.8910	-1.8874	2.0458	-1.0779	0.2182	foam	0.21790	0.11820	{1,2,3}	\N	drench	vertical_up	0.420
80	SSU-К80	\N	\N	1.600	0.100	0.0432	0.5918	-1.2393	1.3763	-0.7466	0.1551	water	0.18820	0.09130	{1,2,3}	\N	sprinkler	vertical_up	0.420
81	SP-К80	\N	\N	1.600	0.100	0.0147	0.5737	-1.1843	1.2757	-0.6751	0.1379	water	0.14770	0.06140	{1,2,3}	\N	drench	vertical_down	0.420
83	SU-К115	\N	\N	1.600	0.100	0.0303	0.9506	-2.0736	2.2696	-1.1990	0.2429	water	0.22840	0.10680	{1,2,3}	\N	drench	vertical_up	0.600
84	SSU-К115	\N	\N	1.600	0.100	0.0303	0.9506	-2.0736	2.2696	-1.1990	0.2429	water	0.22840	0.10680	{1,2,3}	\N	sprinkler	vertical_up	0.600
85	SU-К115	\N	\N	1.600	0.150	0.0021	1.3894	-3.1633	3.5809	-1.9378	0.3989	foam	0.27770	0.15050	{1,2,3}	\N	drench	vertical_up	0.600
86	SP-К115	\N	\N	1.600	0.150	-0.0238	1.4005	-3.1885	3.5833	-1.9247	0.3939	foam	0.24830	0.12570	{1,2,3}	\N	drench	vertical_down	0.600
87	SP-К115	\N	\N	1.600	0.100	0.0279	0.7763	-1.5903	1.6875	-0.8770	0.1760	water	0.20880	0.09120	{1,2,3}	\N	drench	vertical_down	0.600
88	ОЭ-16	\N	\N	1.000	0.150	0.0407	0.5405	-0.5051	0.1803	0.0000	0.0000	foam	0.25640	0.11100	{2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.280
94	CУВ-К200	\N	\N	1.000	0.150	0.1124	0.9585	-0.6439	0.1342	0.0000	0.0000	foam	0.56120	0.24210	{3,4.1,4.2,5,6}	\N		vertical_up	1.050
95	СУН-К200	\N	\N	1.000	0.150	0.1043	1.4740	-1.2731	0.4145	0.0000	0.0000	foam	0.71970	0.29820	{3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	1.050
96	ДУН-К200	\N	\N	1.000	0.050	0.0857	1.2360	-0.9033	0.2216	0.0000	0.0000	water	0.64000	0.14530	{3,4.1,4.2,5,6}	\N	drench	vertical_down	1.050
97	ДУН-К200	\N	\N	1.000	0.150	0.1043	1.4740	-1.2731	0.4145	0.0000	0.0000	foam	0.71970	0.29820	{3,4.1,4.2,5,6}	\N	drench	vertical_down	1.050
98	СУУ-К115	\N	\N	1.000	0.150	-0.0169	1.6773	-5.2109	8.1650	-6.1812	1.7957	foam	0.22900	0.14200	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.600
109	СУУ-12	\N	\N	1.000	0.150	-0.0076	1.2957	-3.9449	6.0796	-4.5569	1.3174	foam	0.18330	0.11630	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.470
112	ССН-12	\N	\N	1.000	0.100	0.0000	0.0000	0.1209	-0.5346	0.7656	0.3079	water	0.65980	0.00080	{5,6}	3.0	sprinkler	vertical_down	0.470
115	ССВ-12	\N	\N	1.000	0.100	0.2646	1.0801	-0.9943	0.4004	0.0000	0.0000	water	0.75080	0.36310	{5,6}	3.0	sprinkler	vertical_up	0.470
89	ОЭ-25	\N	\N	1.000	0.150	0.1644	1.3681	-1.3274	0.4854	0.0000	0.0000	foam	0.69050	0.34140	{2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.850
90	ОЦ-9	\N	\N	1.600	0.150	0.0549	0.1140	-0.0725	0.0160	0.0000	0.0000	foam	0.11720	0.07040	{2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.130
91	ОЦ-12	\N	\N	1.600	0.150	0.0853	0.1209	-0.0967	0.0269	0.0000	0.0000	foam	0.14140	0.10140	{2,3,4.1,4.2,5,6}	\N	drench	vertical_down	0.160
92	ДУВ-К200	\N	\N	1.000	0.050	0.0691	1.2164	-0.9229	0.2480	0.0000	0.0000	water	0.61060	0.12760	{3,4.1,4.2,5,6}	\N	drench	vertical_up	1.050
93	ДУВ-К200	\N	\N	1.000	0.150	0.1124	0.9585	-0.6439	0.1342	0.0000	0.0000	foam	0.56120	0.24210	{3,4.1,4.2,5,6}	\N	drench	vertical_up	1.050
99	SP-К80	\N	\N	1.600	0.150	0.0091	0.8191	-1.7878	1.9880	-1.0666	0.2187	foam	0.18890	0.09790	{1,2,3}	\N	drench	vertical_down	0.420
100	SSP-К80	\N	\N	1.600	0.150	0.0091	0.8191	-1.7878	1.9880	-1.0666	0.2187	foam	0.18890	0.09790	{1,2,3}	\N	sprinkler	vertical_down	0.420
102	СОБР-17-Н	\N	\N	1.200	0.100	0.2481	0.6530	1.1766	-1.5342	0.5226	0.0000	water	1.15860	0.32370	{3,4.1,4.2,5,6}	\N		vertical_down	1.280
103	СОБР-17-В	\N	\N	1.200	0.100	0.1445	2.3194	-2.2376	1.1755	-0.2485	0.0000	water	1.22160	0.35520	{3,4.1,4.2,5,6}	\N		vertical_up	1.280
104	СОБР-25-Н	\N	\N	1.200	0.100	0.2344	2.3107	-2.3449	1.5212	-0.4151	0.0000	water	1.39850	0.44350	{3,4.1,4.2,5,6}	\N		vertical_down	1.910
105	СОБР-25-В	\N	\N	1.200	0.100	0.2963	3.4220	-4.7509	3.6300	-1.1160	0.0000	water	1.51990	0.59450	{3,4.1,4.2,5,6}	\N		vertical_up	1.910
106	СУУ-К80	\N	\N	1.000	0.050	-0.0131	1.0322	-2.8626	4.2927	-3.1334	0.8734	water	0.18920	0.03190	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.420
107	СУУ-15	\N	\N	1.000	0.050	-0.0006	1.7027	-5.1591	7.9720	-5.9275	1.6816	water	0.26910	0.07260	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.770
108	СУУ-К160	\N	\N	1.000	0.050	0.0042	1.9212	-5.9184	9.2800	-7.0370	2.0437	water	0.29370	0.08660	{1,2,3,4.1,4.2,5,6}	\N	sprinkler	vertical_down	0.840
\.


--
-- Data for Name: tubes_tubetype; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.tubes_tubetype (id, name) FROM stdin;
1	Стальные электросварные по ГОСТ 10704
2	Стальные водогазопроводные по ГОСТ 3262
\.


--
-- Data for Name: tubes_type; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.tubes_type (id, nom_size, ext_size, thickness, k_t, tube_type_id) FROM stdin;
1	15.0	18.0	2.0	0.0755	1
2	20.0	25.0	2.0	0.7500	1
3	25.0	32.0	2.2	3.4400	1
4	32.0	40.0	2.2	13.9700	1
5	40.0	45.0	2.2	28.7000	1
6	50.0	57.0	2.5	110.0000	1
7	65.0	76.0	2.8	572.0000	1
8	80.0	89.0	2.8	1429.0000	1
9	100.0	108.0	2.8	4322.0000	1
10	100.0	108.0	3.0	4231.0000	1
11	100.0	114.0	2.8	5872.0000	1
12	125.0	133.0	3.2	13530.0000	1
13	125.0	140.0	3.2	18070.0000	1
14	150.0	159.0	3.2	36920.0000	1
15	150.0	159.0	4.0	34880.0000	1
16	200.0	219.0	4.0	209900.0000	1
17	250.0	273.0	4.0	711300.0000	1
18	300.0	325.0	4.0	1856000.0000	1
19	350.0	377.0	5.0	4062000.0000	1
20	15.0	21.3	2.5	0.1800	2
21	20.0	26.8	2.5	0.9260	2
22	25.0	33.5	2.8	3.6500	2
23	32.0	42.3	2.8	16.5000	2
24	40.0	48.0	3.0	34.5000	2
25	50.0	60.0	3.0	135.0000	2
26	65.0	75.5	3.2	517.0000	2
27	80.0	88.5	3.5	1262.0000	2
28	90.0	101.0	3.5	2725.0000	2
29	100.0	114.0	4.0	5205.0000	2
30	125.0	140.0	4.0	16940.0000	2
31	150.0	165.0	4.0	43000.0000	2
\.


--
-- Data for Name: users_calculateresult; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.users_calculateresult (id, created_at, data, user_id) FROM stdin;
857c1d3a-8565-4873-be3c-eed7b054ede6	2025-12-17 08:20:00.58662+00	{"pipeDN": null, "branches": {"1": {"kt": "5872.0000", "results": {"P_total": 18.219253005440855, "Q_total": 8.011271200283327}}, "2": {"kt": ""}, "3": {"kt": ""}}, "feedPipe": {"kt": "4322.0000", "length": 3, "results": {"P_total": 18.263802149062666, "Q_total": 8.011271200283327}}, "pipeType": null, "kt_values": {"1": "5872.0000", "2": "", "3": ""}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-17T08:19:59.879Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {}, "controlUnit": "Узел управления спринклерный водозаполненный «‎Шалтан»", "totalLosses": 18.263802149062666, "branchDetails": {"branch-1": {"kt": "5872.0000", "rows": [{"flow": "2.00", "name": "Ороситель 1а", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1а-2а", "action": "-", "length": "1", "pressure": "18.15", "is_sprinkler": false, "pressure_loss": "0.001"}, {"flow": "2.00", "name": "Ороситель 2а", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.00", "name": "Участок 2а-3а", "action": "-", "length": "2", "pressure": "18.16", "is_sprinkler": false, "pressure_loss": "0.005"}, {"flow": "2.00", "name": "Ороситель 3а", "action": "-", "length": "-", "pressure": "18.16", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.01", "name": "Участок 3а-4а", "action": "-", "length": "3", "pressure": "18.18", "is_sprinkler": false, "pressure_loss": "0.018"}, {"flow": "2.00", "name": "Ороситель 4а", "action": "-", "length": "-", "pressure": "18.18", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "8.01", "name": "Участок 4а-5а", "action": "-", "length": "4", "pressure": "18.22", "is_sprinkler": false, "pressure_loss": "0.044"}, {"flow": "-", "name": "Ороситель 5а", "action": "-", "length": "-", "pressure": "-", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "-", "name": "Участок 5а-6а", "action": "-", "length": "-", "pressure": "-", "is_sprinkler": false, "pressure_loss": "-"}, {"flow": "8.01", "name": "Узел а-б", "action": "-", "length": "-", "pressure": "18.22", "is_sprinkler": false, "pressure_loss": "-"}], "branch_num": "а"}}, "branch_results": {"1": {"P_total": 18.219253005440855, "Q_total": 8.011271200283327}, "feed-pipe": {"P_total": 18.263802149062666, "Q_total": 8.011271200283327}}, "installationType": "sprinkler_water"}	4
96022210-ef69-467e-8bd7-4bb1c2b0537d	2025-12-17 08:23:26.120487+00	{"pipeDN": null, "branches": {"1": {"kt": "28.7000", "results": {"P_total": 21.868957073215196, "Q_total": 6.121147683315485}}, "2": {"kt": ""}, "3": {"kt": ""}}, "feedPipe": {"kt": "1429.0000", "length": 5, "results": {"P_total": 22.00005731450616, "Q_total": 6.121147683315485}}, "pipeType": null, "kt_values": {"1": "28.7000", "2": "", "3": ""}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-17T08:23:32.409Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {}, "controlUnit": "Узел управления спринклерный водозаполненный «‎Шалтан»", "totalLosses": 22.00005731450616, "branchDetails": {"branch-1": {"kt": "28.7000", "rows": [{"flow": "2.00", "name": "Ороситель 1а", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1а-2а", "action": "-", "length": "2.5", "pressure": "18.50", "is_sprinkler": false, "pressure_loss": "0.349"}, {"flow": "2.02", "name": "Ороситель 2а", "action": "-", "length": "-", "pressure": "18.50", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.02", "name": "Участок 2а-3а", "action": "-", "length": "2.5", "pressure": "19.91", "is_sprinkler": false, "pressure_loss": "1.410"}, {"flow": "2.10", "name": "Ороситель 3а", "action": "-", "length": "-", "pressure": "19.91", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.12", "name": "Участок 3а-4а", "action": "-", "length": "1.5", "pressure": "21.87", "is_sprinkler": false, "pressure_loss": "1.958"}, {"flow": "6.12", "name": "Узел а-б", "action": "-", "length": "-", "pressure": "21.87", "is_sprinkler": false, "pressure_loss": "-"}], "branch_num": "а"}}, "branch_results": {"1": {"P_total": 21.868957073215196, "Q_total": 6.121147683315485}, "feed-pipe": {"P_total": 22.00005731450616, "Q_total": 6.121147683315485}}, "installationType": "sprinkler_water"}	\N
4a190331-2d20-4b70-a04c-46b22231ffc0	2025-12-17 08:24:51.578668+00	{"pipeDN": null, "branches": {"1": {"kt": ""}, "2": {"kt": "110.0000", "results": {"P_total": 18.846724829608732, "Q_total": 6.0312091640327665}}}, "feedPipe": {"kt": "5205.0000", "length": 23, "results": {"P_total": 19.007461838551517, "Q_total": 6.0312091640327665}}, "pipeType": null, "kt_values": {"1": "", "2": "110.0000"}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-17T08:24:57.476Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {}, "controlUnit": "Узел управления спринклерный прямоточный с устройством задержки", "totalLosses": 19.007461838551517, "branchDetails": {"branch-2": {"kt": "110.0000", "rows": [{"flow": "2.00", "name": "Ороситель 1б", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1б-2б", "action": "-", "length": "2", "pressure": "18.22", "is_sprinkler": false, "pressure_loss": "0.073"}, {"flow": "2.01", "name": "Ороситель 2б", "action": "-", "length": "-", "pressure": "18.22", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.01", "name": "Участок 2б-3б", "action": "-", "length": "2", "pressure": "18.52", "is_sprinkler": false, "pressure_loss": "0.292"}, {"flow": "2.02", "name": "Ороситель 3б", "action": "-", "length": "-", "pressure": "18.52", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.03", "name": "Участок 3б-4б", "action": "-", "length": "1", "pressure": "18.85", "is_sprinkler": false, "pressure_loss": "0.331"}, {"flow": "6.03", "name": "Узел б-в", "action": "-", "length": "-", "pressure": "18.85", "is_sprinkler": false, "pressure_loss": "-"}], "branch_num": "б"}}, "branch_results": {"2": {"P_total": 18.846724829608732, "Q_total": 6.0312091640327665}, "feed-pipe": {"P_total": 19.007461838551517, "Q_total": 6.0312091640327665}}, "installationType": "sprinkler_water"}	\N
61e094e9-9a06-48be-a3a5-a1819b6211a6	2025-12-17 08:25:42.949769+00	{"pipeDN": null, "branches": {"1": {"kt": "28.7000", "results": {"P_total": 21.868957073215196, "Q_total": 6.121147683315485}}, "2": {"kt": "110.0000", "results": {"P_total": 18.846724829608732, "Q_total": 6.0312091640327665}}, "3": {"kt": ""}}, "feedPipe": {"kt": "1429.0000", "length": 5, "results": {"P_total": 77.90093960538417, "Q_total": 12.617962401912937}}, "pipeType": null, "kt_values": {"1": "28.7000", "2": "110.0000", "3": ""}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-17T08:25:49.240Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {"connection-1": {"P_total": 77.34386131575475, "Q_total": 12.617962401912937}}, "controlUnit": "Узел управления спринклерный прямоточный с устройством задержки", "totalLosses": 77.90093960538417, "branchDetails": {"branch-1": {"kt": "28.7000", "rows": [{"flow": "2.00", "name": "Ороситель 1а", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1а-2а", "action": "-", "length": "2.5", "pressure": "18.50", "is_sprinkler": false, "pressure_loss": "0.349"}, {"flow": "2.02", "name": "Ороситель 2а", "action": "-", "length": "-", "pressure": "18.50", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.02", "name": "Участок 2а-3а", "action": "-", "length": "2.5", "pressure": "19.91", "is_sprinkler": false, "pressure_loss": "1.410"}, {"flow": "2.10", "name": "Ороситель 3а", "action": "-", "length": "-", "pressure": "19.91", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.12", "name": "Участок 3а-4а", "action": "-", "length": "1.5", "pressure": "21.87", "is_sprinkler": false, "pressure_loss": "1.958"}, {"flow": "12.62", "name": "Узел а-б", "action": "-", "length": "10.0", "pressure": "77.34", "is_sprinkler": false, "pressure_loss": "55.47"}], "branch_num": "а"}, "branch-2": {"kt": "110.0000", "rows": [{"flow": "2.00", "name": "Ороситель 1б", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1б-2б", "action": "-", "length": "2", "pressure": "18.22", "is_sprinkler": false, "pressure_loss": "0.073"}, {"flow": "2.01", "name": "Ороситель 2б", "action": "-", "length": "-", "pressure": "18.22", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.01", "name": "Участок 2б-3б", "action": "-", "length": "2", "pressure": "18.52", "is_sprinkler": false, "pressure_loss": "0.292"}, {"flow": "2.02", "name": "Ороситель 3б", "action": "-", "length": "-", "pressure": "18.52", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.03", "name": "Участок 3б-4б", "action": "-", "length": "1", "pressure": "18.85", "is_sprinkler": false, "pressure_loss": "0.331"}, {"flow": "6.03", "name": "Узел б-в", "action": "-", "length": "-", "pressure": "18.85", "is_sprinkler": false, "pressure_loss": "-"}], "branch_num": "б"}}, "branch_results": {"1": {"P_total": 21.868957073215196, "Q_total": 6.121147683315485}, "2": {"P_total": 18.846724829608732, "Q_total": 6.0312091640327665}, "feed-pipe": {"P_total": 77.90093960538417, "Q_total": 12.617962401912937}, "connection-1": {"P_total": 77.34386131575475, "Q_total": 12.617962401912937}}, "installationType": "sprinkler_water"}	\N
f00b6404-7370-45a0-809d-1f1966646d2c	2025-12-17 08:26:20.14613+00	{"pipeDN": null, "branches": {"1": {"kt": ""}, "2": {"kt": "110.0000", "results": {"P_total": 18.846724829608732, "Q_total": 6.0312091640327665}}}, "feedPipe": {"kt": "5205.0000", "length": 23, "results": {"P_total": 19.007461838551517, "Q_total": 6.0312091640327665}}, "pipeType": null, "kt_values": {"1": "", "2": "110.0000"}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-17T08:26:26.047Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {}, "controlUnit": "Узел управления спринклерный прямоточный с устройством задержки", "totalLosses": 19.007461838551517, "branchDetails": {"branch-2": {"kt": "110.0000", "rows": [{"flow": "2.00", "name": "Ороситель 1б", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1б-2б", "action": "-", "length": "2", "pressure": "18.22", "is_sprinkler": false, "pressure_loss": "0.073"}, {"flow": "2.01", "name": "Ороситель 2б", "action": "-", "length": "-", "pressure": "18.22", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.01", "name": "Участок 2б-3б", "action": "-", "length": "2", "pressure": "18.52", "is_sprinkler": false, "pressure_loss": "0.292"}, {"flow": "2.02", "name": "Ороситель 3б", "action": "-", "length": "-", "pressure": "18.52", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.03", "name": "Участок 3б-4б", "action": "-", "length": "1", "pressure": "18.85", "is_sprinkler": false, "pressure_loss": "0.331"}, {"flow": "6.03", "name": "Узел б-в", "action": "-", "length": "-", "pressure": "18.85", "is_sprinkler": false, "pressure_loss": "-"}], "branch_num": "б"}}, "branch_results": {"2": {"P_total": 18.846724829608732, "Q_total": 6.0312091640327665}, "feed-pipe": {"P_total": 19.007461838551517, "Q_total": 6.0312091640327665}}, "installationType": "sprinkler_water"}	\N
901fad1f-4519-4674-a3f0-d643d1ff04fd	2025-12-17 08:51:42.055106+00	{"pipeDN": null, "branches": {"1": {"kt": "28.7000", "results": {"P_total": 24.21115444724736, "Q_total": 6.143582216287529}}, "2": {"kt": "28.7000", "results": {"P_total": 44.5691818426437, "Q_total": 11.101846080592216}}}, "feedPipe": {"kt": "4322.0000", "length": 10, "results": {"P_total": 71.77156929569718, "Q_total": 19.437338414100097}}, "pipeType": null, "kt_values": {"1": "28.7000", "2": "28.7000"}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-17T08:51:47.882Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {"connection-1": {"P_total": 70.8974135237762, "Q_total": 19.437338414100097}}, "controlUnit": "Узел управления спринклерный прямоточный с устройством задержки", "totalLosses": 71.77156929569718, "branchDetails": {"branch-1": {"kt": "28.7000", "rows": [{"flow": "2.00", "name": "Ороситель 1а", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1а-2а", "action": "-", "length": "3", "pressure": "18.57", "is_sprinkler": false, "pressure_loss": "0.419"}, {"flow": "2.03", "name": "Ороситель 2а", "action": "-", "length": "-", "pressure": "18.57", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.03", "name": "Участок 2а-3а", "action": "-", "length": "3", "pressure": "20.27", "is_sprinkler": false, "pressure_loss": "1.696"}, {"flow": "2.12", "name": "Ороситель 3а", "action": "-", "length": "-", "pressure": "20.27", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.14", "name": "Участок 3а-4а", "action": "-", "length": "3", "pressure": "24.21", "is_sprinkler": false, "pressure_loss": "3.945"}, {"flow": "19.44", "name": "Узел а-б", "action": "-", "length": "2.0", "pressure": "70.90", "is_sprinkler": false, "pressure_loss": "26.33"}], "branch_num": "а"}, "branch-2": {"kt": "28.7000", "rows": [{"flow": "2.00", "name": "Ороситель 1б", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1б-2б", "action": "-", "length": "3", "pressure": "18.57", "is_sprinkler": false, "pressure_loss": "0.419"}, {"flow": "2.03", "name": "Ороситель 2б", "action": "-", "length": "-", "pressure": "18.57", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.03", "name": "Участок 2б-3б", "action": "-", "length": "3", "pressure": "20.27", "is_sprinkler": false, "pressure_loss": "1.696"}, {"flow": "2.12", "name": "Ороситель 3б", "action": "-", "length": "-", "pressure": "20.27", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.14", "name": "Участок 3б-4б", "action": "-", "length": "3", "pressure": "24.21", "is_sprinkler": false, "pressure_loss": "3.945"}, {"flow": "2.31", "name": "Ороситель 4б", "action": "-", "length": "-", "pressure": "24.21", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "8.46", "name": "Участок 4б-5б", "action": "-", "length": "3", "pressure": "31.69", "is_sprinkler": false, "pressure_loss": "7.475"}, {"flow": "2.65", "name": "Ороситель 5б", "action": "-", "length": "-", "pressure": "31.69", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "11.10", "name": "Участок 5б-6б", "action": "-", "length": "3", "pressure": "44.57", "is_sprinkler": false, "pressure_loss": "12.883"}, {"flow": "11.10", "name": "Узел б-в", "action": "-", "length": "-", "pressure": "44.57", "is_sprinkler": false, "pressure_loss": "-"}], "branch_num": "б"}}, "branch_results": {"1": {"P_total": 24.21115444724736, "Q_total": 6.143582216287529}, "2": {"P_total": 44.5691818426437, "Q_total": 11.101846080592216}, "feed-pipe": {"P_total": 71.77156929569718, "Q_total": 19.437338414100097}, "connection-1": {"P_total": 70.8974135237762, "Q_total": 19.437338414100097}}, "installationType": "sprinkler_water"}	\N
d62420b4-92ef-4182-9705-6e9a306cdb7c	2025-12-17 08:55:45.945777+00	{"pipeDN": null, "branches": {"1": {"kt": "28.7000", "results": {"P_total": 24.21115444724736, "Q_total": 6.143582216287529}}, "2": {"kt": "28.7000", "results": {"P_total": 44.5691818426437, "Q_total": 11.101846080592216}}}, "feedPipe": {"kt": "4322.0000", "length": 10, "results": {"P_total": 71.77156929569718, "Q_total": 19.437338414100097}}, "pipeType": null, "kt_values": {"1": "28.7000", "2": "28.7000"}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-17T08:55:51.785Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {"connection-1": {"P_total": 70.8974135237762, "Q_total": 19.437338414100097}}, "controlUnit": "Узел управления спринклерный прямоточный с устройством задержки", "totalLosses": 71.77156929569718, "branchDetails": {"branch-1": {"kt": "28.7000", "rows": [{"flow": "2.00", "name": "Ороситель 1а", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1а-2а", "action": "-", "length": "3", "pressure": "18.57", "is_sprinkler": false, "pressure_loss": "0.419"}, {"flow": "2.03", "name": "Ороситель 2а", "action": "-", "length": "-", "pressure": "18.57", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.03", "name": "Участок 2а-3а", "action": "-", "length": "3", "pressure": "20.27", "is_sprinkler": false, "pressure_loss": "1.696"}, {"flow": "2.12", "name": "Ороситель 3а", "action": "-", "length": "-", "pressure": "20.27", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.14", "name": "Участок 3а-4а", "action": "-", "length": "3", "pressure": "24.21", "is_sprinkler": false, "pressure_loss": "3.945"}, {"flow": "19.44", "name": "Узел а-б", "action": "-", "length": "2.0", "pressure": "70.90", "is_sprinkler": false, "pressure_loss": "26.33"}], "branch_num": "а"}, "branch-2": {"kt": "28.7000", "rows": [{"flow": "2.00", "name": "Ороситель 1б", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1б-2б", "action": "-", "length": "3", "pressure": "18.57", "is_sprinkler": false, "pressure_loss": "0.419"}, {"flow": "2.03", "name": "Ороситель 2б", "action": "-", "length": "-", "pressure": "18.57", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.03", "name": "Участок 2б-3б", "action": "-", "length": "3", "pressure": "20.27", "is_sprinkler": false, "pressure_loss": "1.696"}, {"flow": "2.12", "name": "Ороситель 3б", "action": "-", "length": "-", "pressure": "20.27", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.14", "name": "Участок 3б-4б", "action": "-", "length": "3", "pressure": "24.21", "is_sprinkler": false, "pressure_loss": "3.945"}, {"flow": "2.31", "name": "Ороситель 4б", "action": "-", "length": "-", "pressure": "24.21", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "8.46", "name": "Участок 4б-5б", "action": "-", "length": "3", "pressure": "31.69", "is_sprinkler": false, "pressure_loss": "7.475"}, {"flow": "2.65", "name": "Ороситель 5б", "action": "-", "length": "-", "pressure": "31.69", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "11.10", "name": "Участок 5б-6б", "action": "-", "length": "3", "pressure": "44.57", "is_sprinkler": false, "pressure_loss": "12.883"}, {"flow": "11.10", "name": "Узел б-в", "action": "-", "length": "-", "pressure": "44.57", "is_sprinkler": false, "pressure_loss": "-"}], "branch_num": "б"}}, "branch_results": {"1": {"P_total": 24.21115444724736, "Q_total": 6.143582216287529}, "2": {"P_total": 44.5691818426437, "Q_total": 11.101846080592216}, "feed-pipe": {"P_total": 71.77156929569718, "Q_total": 19.437338414100097}, "connection-1": {"P_total": 70.8974135237762, "Q_total": 19.437338414100097}}, "installationType": "sprinkler_water"}	\N
d8ddb2c5-3570-480d-aa8a-6afd0b05ddce	2025-12-17 08:59:41.341912+00	{"pipeDN": null, "branches": {"1": {"kt": "28.7000", "results": {"P_total": 24.21115444724736, "Q_total": 6.143582216287529}}, "2": {"kt": "28.7000", "results": {"P_total": 44.5691818426437, "Q_total": 11.101846080592216}}}, "feedPipe": {"kt": "4322.0000", "length": 10, "results": {"P_total": 71.77156929569718, "Q_total": 19.437338414100097}}, "pipeType": null, "kt_values": {"1": "28.7000", "2": "28.7000"}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-17T08:59:47.166Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {"connection-1": {"P_total": 70.8974135237762, "Q_total": 19.437338414100097}}, "controlUnit": "Узел управления спринклерный прямоточный с устройством задержки", "totalLosses": 71.77156929569718, "branchDetails": {"branch-1": {"kt": "28.7000", "rows": [{"flow": "2.00", "name": "Ороситель 1а", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1а-2а", "action": "-", "length": "3", "pressure": "18.57", "is_sprinkler": false, "pressure_loss": "0.419"}, {"flow": "2.03", "name": "Ороситель 2а", "action": "-", "length": "-", "pressure": "18.57", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.03", "name": "Участок 2а-3а", "action": "-", "length": "3", "pressure": "20.27", "is_sprinkler": false, "pressure_loss": "1.696"}, {"flow": "2.12", "name": "Ороситель 3а", "action": "-", "length": "-", "pressure": "20.27", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.14", "name": "Участок 3а-4а", "action": "-", "length": "3", "pressure": "24.21", "is_sprinkler": false, "pressure_loss": "3.945"}, {"flow": "19.44", "name": "Узел а-б", "action": "-", "length": "2.0", "pressure": "70.90", "is_sprinkler": false, "pressure_loss": "26.33"}], "branch_num": "а"}, "branch-2": {"kt": "28.7000", "rows": [{"flow": "2.00", "name": "Ороситель 1б", "action": "-", "length": "-", "pressure": "18.15", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "2.00", "name": "Участок 1б-2б", "action": "-", "length": "3", "pressure": "18.57", "is_sprinkler": false, "pressure_loss": "0.419"}, {"flow": "2.03", "name": "Ороситель 2б", "action": "-", "length": "-", "pressure": "18.57", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "4.03", "name": "Участок 2б-3б", "action": "-", "length": "3", "pressure": "20.27", "is_sprinkler": false, "pressure_loss": "1.696"}, {"flow": "2.12", "name": "Ороситель 3б", "action": "-", "length": "-", "pressure": "20.27", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "6.14", "name": "Участок 3б-4б", "action": "-", "length": "3", "pressure": "24.21", "is_sprinkler": false, "pressure_loss": "3.945"}, {"flow": "2.31", "name": "Ороситель 4б", "action": "-", "length": "-", "pressure": "24.21", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "8.46", "name": "Участок 4б-5б", "action": "-", "length": "3", "pressure": "31.69", "is_sprinkler": false, "pressure_loss": "7.475"}, {"flow": "2.65", "name": "Ороситель 5б", "action": "-", "length": "-", "pressure": "31.69", "is_sprinkler": true, "pressure_loss": "-"}, {"flow": "11.10", "name": "Участок 5б-6б", "action": "-", "length": "3", "pressure": "44.57", "is_sprinkler": false, "pressure_loss": "12.883"}, {"flow": "11.10", "name": "Узел б-в", "action": "-", "length": "-", "pressure": "44.57", "is_sprinkler": false, "pressure_loss": "-"}], "branch_num": "б"}}, "branch_results": {"1": {"P_total": 24.21115444724736, "Q_total": 6.143582216287529}, "2": {"P_total": 44.5691818426437, "Q_total": 11.101846080592216}, "feed-pipe": {"P_total": 71.77156929569718, "Q_total": 19.437338414100097}, "connection-1": {"P_total": 70.8974135237762, "Q_total": 19.437338414100097}}, "installationType": "sprinkler_water"}	\N
19063b6c-d7ce-45de-a382-85859973e190	2025-12-18 03:18:44.1242+00	{"pipeDN": null, "branches": {"1": {"kt": ""}}, "feedPipe": {"kt": "4322.0000", "length": 10, "results": {"P_total": 65.52947375616925, "Q_total": 11.480133190030232}}, "pipeType": null, "kt_values": {"1": ""}, "sprinkler": {"flow": "2.00 л/с", "type": "СУУ-12", "k_factor": "0.470 дм3/(с ‧ МПа0,5)", "pressure": "18.15 м"}, "timestamp": "2025-12-18T03:18:50.182Z", "formValues": {"otv": "water", "temp": "20", "group": "2", "height": "7.00"}, "connections": {"connection-1": {"P_total": 65.22453748115575, "Q_total": 11.480133190030232}}, "controlUnit": "Узел управления спринклерный водозаполненный «‎Шалтан»", "totalLosses": 65.52947375616925, "branchDetails": {}, "branch_results": {"feed-pipe": {"P_total": 65.52947375616925, "Q_total": 11.480133190030232}, "connection-1": {"P_total": 65.22453748115575, "Q_total": 11.480133190030232}}, "installationType": "sprinkler_water"}	\N
\.


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.users_user (id, password, last_login, is_superuser, username, email, is_staff, is_active, date_joined, first_name, last_name, parent_name) FROM stdin;
3	pbkdf2_sha256$390000$FnYy3f8RgKJIdEhh5fDaoN$AFe5jSpu+NnT9yD7cH5S+1B43sjY6KjOCbfB3yR/3QQ=	2024-10-01 01:12:16.137204+00	t	admin	admin@admin.ru	t	t	2024-08-09 02:41:52.895303+00	\N	\N	\N
1	pbkdf2_sha256$390000$eypDe8J6TeqDmvBgeyt7CQ$5a43OgncDPHpA/ufZfpohH3N38Op+hdK93YbMGCsdXk=	2025-07-04 07:20:32.454336+00	t	buht	lev@larixon.com	t	t	2024-08-09 00:27:20.953983+00	\N	\N	\N
4	pbkdf2_sha256$390000$4egVO5bGkobUxN43trV9Xj$QG4Kt+RWpmmRqURccRHd4ykf9oUXXaB8N4Y7DtC3Mw4=	2025-12-17 02:13:03.391576+00	t	sasha	sasha@admin.ru	t	t	2025-07-04 07:19:25.208966+00	\N	\N	\N
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: specauto
--

COPY public.users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 435, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 41, true);


--
-- Name: main_seosettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.main_seosettings_id_seq', 1, false);


--
-- Name: management_node_controlunit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.management_node_controlunit_id_seq', 27, true);


--
-- Name: management_node_controlunitname_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.management_node_controlunitname_id_seq', 8, true);


--
-- Name: sprinkler_sprinkler_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.sprinkler_sprinkler_id_seq', 115, true);


--
-- Name: tubes_tubetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.tubes_tubetype_id_seq', 2, true);


--
-- Name: tubes_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.tubes_type_id_seq', 31, true);


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.users_user_id_seq', 4, true);


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: specauto
--

SELECT pg_catalog.setval('public.users_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: main_seosettings main_seosettings_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.main_seosettings
    ADD CONSTRAINT main_seosettings_pkey PRIMARY KEY (id);


--
-- Name: management_node_controlunit management_node_controlunit_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.management_node_controlunit
    ADD CONSTRAINT management_node_controlunit_pkey PRIMARY KEY (id);


--
-- Name: management_node_controlunitname management_node_controlunitname_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.management_node_controlunitname
    ADD CONSTRAINT management_node_controlunitname_pkey PRIMARY KEY (id);


--
-- Name: sprinkler_sprinkler sprinkler_sprinkler_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.sprinkler_sprinkler
    ADD CONSTRAINT sprinkler_sprinkler_pkey PRIMARY KEY (id);


--
-- Name: tubes_tubetype tubes_tubetype_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.tubes_tubetype
    ADD CONSTRAINT tubes_tubetype_pkey PRIMARY KEY (id);


--
-- Name: tubes_type tubes_type_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.tubes_type
    ADD CONSTRAINT tubes_type_pkey PRIMARY KEY (id);


--
-- Name: users_calculateresult users_calculateresults_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_calculateresult
    ADD CONSTRAINT users_calculateresults_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_user_id_group_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_permission_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: management_node_controlunit_control_unit_name_id_b7084b30; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX management_node_controlunit_control_unit_name_id_b7084b30 ON public.management_node_controlunit USING btree (control_unit_name_id);


--
-- Name: tubes_type_tube_type_id_392b3b62; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX tubes_type_tube_type_id_392b3b62 ON public.tubes_type USING btree (tube_type_id);


--
-- Name: users_calculateresults_user_id_e1a32400; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX users_calculateresults_user_id_e1a32400 ON public.users_calculateresult USING btree (user_id);


--
-- Name: users_user_groups_group_id_9afc8d0e; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX users_user_groups_group_id_9afc8d0e ON public.users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_user_id_5f6f5a90; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX users_user_groups_user_id_5f6f5a90 ON public.users_user_groups USING btree (user_id);


--
-- Name: users_user_user_permissions_permission_id_0b93982e; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX users_user_user_permissions_permission_id_0b93982e ON public.users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_user_id_20aca447; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX users_user_user_permissions_user_id_20aca447 ON public.users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: specauto
--

CREATE INDEX users_user_username_06e46fe6_like ON public.users_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: management_node_controlunit management_node_cont_control_unit_name_id_b7084b30_fk_managemen; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.management_node_controlunit
    ADD CONSTRAINT management_node_cont_control_unit_name_id_b7084b30_fk_managemen FOREIGN KEY (control_unit_name_id) REFERENCES public.management_node_controlunitname(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tubes_type tubes_type_tube_type_id_392b3b62_fk_tubes_tubetype_id; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.tubes_type
    ADD CONSTRAINT tubes_type_tube_type_id_392b3b62_fk_tubes_tubetype_id FOREIGN KEY (tube_type_id) REFERENCES public.tubes_tubetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_calculateresult users_calculateresults_user_id_e1a32400_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_calculateresult
    ADD CONSTRAINT users_calculateresults_user_id_e1a32400_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_perm_permission_id_0b93982e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: specauto
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict MS4scBUqUUKLxBAfYpC3kvRQDrysstFS4sly2BWcLgcolajnYlCn06pswNxrEc4

