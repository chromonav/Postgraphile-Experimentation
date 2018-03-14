--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.1
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP TRIGGER person_updated_at ON sellezely.person;
DROP TRIGGER peep_updated_at ON sellezely.peep;
ALTER TABLE ONLY sellezely.person DROP CONSTRAINT person_pkey;
ALTER TABLE ONLY sellezely.article DROP CONSTRAINT article_pkey;
ALTER TABLE sellezely.person ALTER COLUMN id DROP DEFAULT;
ALTER TABLE sellezely.peep ALTER COLUMN id DROP DEFAULT;
ALTER TABLE sellezely.article ALTER COLUMN article_id DROP DEFAULT;
DROP SEQUENCE sellezely.person_id_seq;
DROP TABLE sellezely.person;
DROP SEQUENCE sellezely.peep_id_seq;
DROP TABLE sellezely.peep;
DROP SEQUENCE sellezely.article_article_id_seq;
DROP TABLE sellezely.article;
DROP FUNCTION sellezely.set_updated_at();
DROP SCHEMA sellezely;
--
-- Name: sellezely; Type: SCHEMA; Schema: -; Owner: mtdaclpg
--

CREATE SCHEMA sellezely;


ALTER SCHEMA sellezely OWNER TO mtdaclpg;

--
-- Name: set_updated_at(); Type: FUNCTION; Schema: sellezely; Owner: mtdaclpg
--

CREATE FUNCTION sellezely.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
  new.updated_at := current_timestamp;
  return new;
end;
$$;


ALTER FUNCTION sellezely.set_updated_at() OWNER TO mtdaclpg;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: article; Type: TABLE; Schema: sellezely; Owner: mtdaclpg
--

CREATE TABLE sellezely.article (
    article_id bigint NOT NULL,
    article_name character varying(20) NOT NULL,
    article_desc text NOT NULL,
    date_added timestamp without time zone
);


ALTER TABLE sellezely.article OWNER TO mtdaclpg;

--
-- Name: article_article_id_seq; Type: SEQUENCE; Schema: sellezely; Owner: mtdaclpg
--

CREATE SEQUENCE sellezely.article_article_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sellezely.article_article_id_seq OWNER TO mtdaclpg;

--
-- Name: article_article_id_seq; Type: SEQUENCE OWNED BY; Schema: sellezely; Owner: mtdaclpg
--

ALTER SEQUENCE sellezely.article_article_id_seq OWNED BY sellezely.article.article_id;


--
-- Name: peep; Type: TABLE; Schema: sellezely; Owner: mtdaclpg
--

CREATE TABLE sellezely.peep (
    peep_name text,
    id integer NOT NULL,
    created_at time without time zone DEFAULT now() NOT NULL,
    updated_at time without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sellezely.peep OWNER TO mtdaclpg;

--
-- Name: peep_id_seq; Type: SEQUENCE; Schema: sellezely; Owner: mtdaclpg
--

CREATE SEQUENCE sellezely.peep_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sellezely.peep_id_seq OWNER TO mtdaclpg;

--
-- Name: peep_id_seq; Type: SEQUENCE OWNED BY; Schema: sellezely; Owner: mtdaclpg
--

ALTER SEQUENCE sellezely.peep_id_seq OWNED BY sellezely.peep.id;


--
-- Name: person; Type: TABLE; Schema: sellezely; Owner: mtdaclpg
--

CREATE TABLE sellezely.person (
    id integer NOT NULL,
    first_name text,
    last_name text,
    about text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT person_first_name_check CHECK ((char_length(first_name) < 80)),
    CONSTRAINT person_last_name_check CHECK ((char_length(last_name) < 80))
);


ALTER TABLE sellezely.person OWNER TO mtdaclpg;

--
-- Name: person_id_seq; Type: SEQUENCE; Schema: sellezely; Owner: mtdaclpg
--

CREATE SEQUENCE sellezely.person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sellezely.person_id_seq OWNER TO mtdaclpg;

--
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: sellezely; Owner: mtdaclpg
--

ALTER SEQUENCE sellezely.person_id_seq OWNED BY sellezely.person.id;


--
-- Name: article article_id; Type: DEFAULT; Schema: sellezely; Owner: mtdaclpg
--

ALTER TABLE ONLY sellezely.article ALTER COLUMN article_id SET DEFAULT nextval('sellezely.article_article_id_seq'::regclass);


--
-- Name: peep id; Type: DEFAULT; Schema: sellezely; Owner: mtdaclpg
--

ALTER TABLE ONLY sellezely.peep ALTER COLUMN id SET DEFAULT nextval('sellezely.peep_id_seq'::regclass);


--
-- Name: person id; Type: DEFAULT; Schema: sellezely; Owner: mtdaclpg
--

ALTER TABLE ONLY sellezely.person ALTER COLUMN id SET DEFAULT nextval('sellezely.person_id_seq'::regclass);


--
-- Name: article article_pkey; Type: CONSTRAINT; Schema: sellezely; Owner: mtdaclpg
--

ALTER TABLE ONLY sellezely.article
    ADD CONSTRAINT article_pkey PRIMARY KEY (article_id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: sellezely; Owner: mtdaclpg
--

ALTER TABLE ONLY sellezely.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: peep peep_updated_at; Type: TRIGGER; Schema: sellezely; Owner: mtdaclpg
--

CREATE TRIGGER peep_updated_at BEFORE UPDATE ON sellezely.peep FOR EACH ROW EXECUTE PROCEDURE sellezely.set_updated_at();


--
-- Name: person person_updated_at; Type: TRIGGER; Schema: sellezely; Owner: mtdaclpg
--

CREATE TRIGGER person_updated_at BEFORE UPDATE ON sellezely.person FOR EACH ROW EXECUTE PROCEDURE sellezely.set_updated_at();


--
-- PostgreSQL database dump complete
--

