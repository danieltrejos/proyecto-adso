PGDMP      0                }            final-db    16.3    16.3 E    L           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            M           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            N           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            O           1262    32804    final-db    DATABASE     ~   CREATE DATABASE "final-db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Mexico.1252';
    DROP DATABASE "final-db";
                postgres    false            �            1259    32805    Product    TABLE     U  CREATE TABLE public."Product" (
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
    DROP TABLE public."Product";
       public         heap    postgres    false            �            1259    32811    Product_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Product_id_seq";
       public          postgres    false    215            P           0    0    Product_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;
          public          postgres    false    216            �            1259    32812    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap    postgres    false            �            1259    32819 	   companies    TABLE     3  CREATE TABLE public.companies (
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
    DROP TABLE public.companies;
       public         heap    postgres    false            �            1259    32827 
   currencies    TABLE     �  CREATE TABLE public.currencies (
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
    DROP TABLE public.currencies;
       public         heap    postgres    false            �            1259    32837    currencies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.currencies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.currencies_id_seq;
       public          postgres    false    219            Q           0    0    currencies_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.currencies_id_seq OWNED BY public.currencies.id;
          public          postgres    false    220            �            1259    32838 	   customers    TABLE       CREATE TABLE public.customers (
    id integer NOT NULL,
    name text NOT NULL,
    email text,
    phone text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    address text
);
    DROP TABLE public.customers;
       public         heap    postgres    false            �            1259    32844    customers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.customers_id_seq;
       public          postgres    false    221            R           0    0    customers_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;
          public          postgres    false    222            �            1259    32845 
   sale_items    TABLE     �   CREATE TABLE public.sale_items (
    id integer NOT NULL,
    quantity integer NOT NULL,
    price double precision NOT NULL,
    "saleId" integer NOT NULL,
    "productId" integer NOT NULL
);
    DROP TABLE public.sale_items;
       public         heap    postgres    false            �            1259    32848    sale_items_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sale_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.sale_items_id_seq;
       public          postgres    false    223            S           0    0    sale_items_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.sale_items_id_seq OWNED BY public.sale_items.id;
          public          postgres    false    224            �            1259    32849    sales    TABLE     c  CREATE TABLE public.sales (
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
    DROP TABLE public.sales;
       public         heap    postgres    false            �            1259    32856    sales_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.sales_id_seq;
       public          postgres    false    225            T           0    0    sales_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;
          public          postgres    false    226            �            1259    32857    taxes    TABLE     ]  CREATE TABLE public.taxes (
    id integer NOT NULL,
    name text NOT NULL,
    rate double precision NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "isDefault" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.taxes;
       public         heap    postgres    false            �            1259    32865    taxes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.taxes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.taxes_id_seq;
       public          postgres    false    227            U           0    0    taxes_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.taxes_id_seq OWNED BY public.taxes.id;
          public          postgres    false    228            �            1259    32866    users    TABLE       CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    role text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    32872    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    229            V           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    230            v           2604    32873 
   Product id    DEFAULT     l   ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);
 ;   ALTER TABLE public."Product" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            }           2604    32874    currencies id    DEFAULT     n   ALTER TABLE ONLY public.currencies ALTER COLUMN id SET DEFAULT nextval('public.currencies_id_seq'::regclass);
 <   ALTER TABLE public.currencies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            �           2604    32875    customers id    DEFAULT     l   ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);
 ;   ALTER TABLE public.customers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            �           2604    32876    sale_items id    DEFAULT     n   ALTER TABLE ONLY public.sale_items ALTER COLUMN id SET DEFAULT nextval('public.sale_items_id_seq'::regclass);
 <   ALTER TABLE public.sale_items ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    32877    sales id    DEFAULT     d   ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);
 7   ALTER TABLE public.sales ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225            �           2604    32878    taxes id    DEFAULT     d   ALTER TABLE ONLY public.taxes ALTER COLUMN id SET DEFAULT nextval('public.taxes_id_seq'::regclass);
 7   ALTER TABLE public.taxes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            �           2604    32879    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229            :          0    32805    Product 
   TABLE DATA           o   COPY public."Product" (id, name, description, price, image, "createdAt", "updatedAt", stock, type) FROM stdin;
    public          postgres    false    215   5U       <          0    32812    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public          postgres    false    217   �X       =          0    32819 	   companies 
   TABLE DATA           �   COPY public.companies (id, name, registration_number, email, phone, currency, timezone, logo, street, city, region_province, postal_code, country, created_at, updated_at) FROM stdin;
    public          postgres    false    218   �[       >          0    32827 
   currencies 
   TABLE DATA           �   COPY public.currencies (id, code, name, symbol, "precision", "thousandSeparator", "decimalSeparator", "isActive", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    219   �\       @          0    32838 	   customers 
   TABLE DATA           ^   COPY public.customers (id, name, email, phone, "createdAt", "updatedAt", address) FROM stdin;
    public          postgres    false    221   �]       B          0    32845 
   sale_items 
   TABLE DATA           P   COPY public.sale_items (id, quantity, price, "saleId", "productId") FROM stdin;
    public          postgres    false    223   _       D          0    32849    sales 
   TABLE DATA           �   COPY public.sales (id, total, "paymentAmount", change, "paymentMethod", "createdAt", "updatedAt", "userId", "customerId", "companyId", "invoiceNumber", subtotal, "taxAmount", "taxRate") FROM stdin;
    public          postgres    false    225   `       F          0    32857    taxes 
   TABLE DATA           b   COPY public.taxes (id, name, rate, "isActive", "isDefault", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    227   <b       H          0    32866    users 
   TABLE DATA           P   COPY public.users (id, name, email, role, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    229   �b       W           0    0    Product_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Product_id_seq"', 12, true);
          public          postgres    false    216            X           0    0    currencies_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.currencies_id_seq', 11, true);
          public          postgres    false    220            Y           0    0    customers_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.customers_id_seq', 6, true);
          public          postgres    false    222            Z           0    0    sale_items_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.sale_items_id_seq', 35, true);
          public          postgres    false    224            [           0    0    sales_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.sales_id_seq', 17, true);
          public          postgres    false    226            \           0    0    taxes_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.taxes_id_seq', 4, true);
          public          postgres    false    228            ]           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 3, true);
          public          postgres    false    230            �           2606    32881    Product Product_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Product" DROP CONSTRAINT "Product_pkey";
       public            postgres    false    215            �           2606    32883 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public            postgres    false    217            �           2606    32885    companies companies_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.companies DROP CONSTRAINT companies_pkey;
       public            postgres    false    218            �           2606    32887    currencies currencies_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.currencies DROP CONSTRAINT currencies_pkey;
       public            postgres    false    219            �           2606    32889    customers customers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public            postgres    false    221            �           2606    32891    sale_items sale_items_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT sale_items_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.sale_items DROP CONSTRAINT sale_items_pkey;
       public            postgres    false    223            �           2606    32893    sales sales_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.sales DROP CONSTRAINT sales_pkey;
       public            postgres    false    225            �           2606    32895    taxes taxes_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.taxes
    ADD CONSTRAINT taxes_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.taxes DROP CONSTRAINT taxes_pkey;
       public            postgres    false    227            �           2606    32897    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    229            �           1259    32898    Product_name_key    INDEX     O   CREATE UNIQUE INDEX "Product_name_key" ON public."Product" USING btree (name);
 &   DROP INDEX public."Product_name_key";
       public            postgres    false    215            �           1259    32899    companies_email_key    INDEX     Q   CREATE UNIQUE INDEX companies_email_key ON public.companies USING btree (email);
 '   DROP INDEX public.companies_email_key;
       public            postgres    false    218            �           1259    32900    currencies_code_key    INDEX     Q   CREATE UNIQUE INDEX currencies_code_key ON public.currencies USING btree (code);
 '   DROP INDEX public.currencies_code_key;
       public            postgres    false    219            �           1259    32901    sales_invoiceNumber_key    INDEX     ]   CREATE UNIQUE INDEX "sales_invoiceNumber_key" ON public.sales USING btree ("invoiceNumber");
 -   DROP INDEX public."sales_invoiceNumber_key";
       public            postgres    false    225            �           1259    32902    users_email_key    INDEX     I   CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);
 #   DROP INDEX public.users_email_key;
       public            postgres    false    229            �           2606    32903 $   sale_items sale_items_productId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT "sale_items_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public.sale_items DROP CONSTRAINT "sale_items_productId_fkey";
       public          postgres    false    215    4753    223            �           2606    32908 !   sale_items sale_items_saleId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT "sale_items_saleId_fkey" FOREIGN KEY ("saleId") REFERENCES public.sales(id) ON UPDATE CASCADE ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.sale_items DROP CONSTRAINT "sale_items_saleId_fkey";
       public          postgres    false    4768    225    223            �           2606    32913    sales sales_companyId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "sales_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public.companies(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 F   ALTER TABLE ONLY public.sales DROP CONSTRAINT "sales_companyId_fkey";
       public          postgres    false    4758    225    218            �           2606    32918    sales sales_customerId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "sales_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE SET NULL;
 G   ALTER TABLE ONLY public.sales DROP CONSTRAINT "sales_customerId_fkey";
       public          postgres    false    221    225    4763            �           2606    32923    sales sales_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "sales_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 C   ALTER TABLE ONLY public.sales DROP CONSTRAINT "sales_userId_fkey";
       public          postgres    false    225    229    4773            :   _  x���Kn�F�׭S�*�5��G�@�x�Ɠ�^$� ���P��4��ƾM���X�%K���B�.����*1���A���$(���5┫!�CN1K�
5$�?�La��H4DI�d�O1Ph�h���i��Q���6��`88>�B�u�����K��`�jӾ{��u�-��+j[�AS���} <�a0���gED�����ZQ���K�B�HKI��kp��fa��@��7ni�RGT�햤y3K]�̴ֳ`�
|V[,��,�Oo���1�Ce1�*��Uaڴ�,dkg��%�S�&��^p�\�Ĕ�D"F��q4*������إ+Ծa����J�+7k ��73W�5��y��VE����f�u��NkS�6�p�D��cRs�'*�(cz�4�Ш�g��1�p��@�Ǿ1����V�6�.M�<[C0}�;���$�%ڮ�N
��	MN89��k��bb��Dh��] '�W���p�Z*-"��d8�j
��O�}�A�O��p/�^���ӂ�X��
q�{�b4s�����|n1�^��t�[�٘��>��0<&f4���NG�'_oﮮ?ߍ�Ӗ����6j�`�W�JjCwCĘ����}#_��H�ǲ��a=+(Y���Y�y�����ïѣ�y�1���?o�7��4r������_����ˈo�x��/��!�Sr8B,��1D�lVؕ-��&��f���h}25�S�E��O-���	֌����]���V�r_��`itU�~�vF7���K��l3�=��$�E0���1�n�|���Aї7���'��������7�F�3xԐ^�3`����������h�Ї��j<������ �]p      <   ,  x�}�[NcI@��*��E~��6�����%E�!0R�~�4Ӵ��ܪJ�������d[�t+�p�6}���<����C��I�Est�SZch}��T2��E�Y3�،��H���k�[���7�r�u
:&����������߱;�yu�W��# c�ڶ2��V��lN���u'���/Z���9���c4�5�k�*�L&_-7 ����|=U��!���|��mΘ�Hx���,��K�|Hl���L3z��p�m�@�ֺ2}a̼
Z��:B�IU`4RYk)S��J�T��@�P�?>��x�?���?��/���#y�+�54ς���z�͈E:�b��*�yL^N��VZڡ`eYQ�hꐶBW:��#Bk��"
u�w���2~=�x�3IE��sQ'��g/ks��y��F��J�-O�m5��U*G�R2)Y#������Y�T<M�Yd����ЍUx�"��%�Jrjwqڿ��鴿?θ;���r�fYy���Z��L�i3f�A6~�@؍$�	=[��:���GǞ=ݳR�M*d�g&�{����@
}��n�ר���Qp�|7S���bf��Ï��O�@�.(Ɛ�,޴�Q���$�����h��� kͲ�H!K����KIX�Xl�
����αt^��{t�Yv��fy�/(D(����?�È�:��<폏χ�C�ԯס���X8�[�������X9�f�j�����=xdm�D)��V粦Z�Z*s��Ua�g���cŀ�!�L-�B���^>@���}�����������1_$�T�n�����t��      =   �   x�U���0D׷_�ĥ��-�+��ĭ�R�4��zѝ'�drf3�WC��z��l&����7�[�2!$��t���n4v���6�-�'͉c������ښc^a4 �i[Ǒ��K�:��uc�^wֵ���d{�{CB��� 
�H�")9b�(WiL*��*O(�4FL�#f�} �9E      >   .  x���AJ�@���S��ef�N�f��R����7�vЁ8#�ĥW�;o��ē��ҍd�����?�a>`��*�#ò�k[�V�T8C�BT�h�۴�faI��!�wN��&G�JK�-��RKc�6Z�Ë1�O1�����gs����y�+�tr�U�B�͛wN���ȵ�7'���"�ɬ.+'�}{��ك�a�YY2����/|�>���Z"ts����b���ëLԳ^ścȦ���{e*�����(N�$�q��N���	��'k��.*��m��N�yJ�a܋��0��PÆ      @   )  x�}�An�0E��)|��l��	^�UQ�V�l�L!�T� ��u�Sp�N(B)U����xO�ت�#o������*3�*�U��m��(�sO�P�8��h�-"�����~��9��������BN�p�V�j���"��g���_/�<5�����őd���AY�lL�jc"��
@�{�{5����w�7��jW-���z4�C)�Q�f1FK`�b!5i�J4����ۭZ�#�b�#+�6R���(D �4؋&�	�v��3n��A��	����e�0(x��4�݆�w�{��!˲o�q��      B   �   x�M�I�D1C��0�0e�K��m��S�Az2�	����Z��0�g�l�!!�.�d��`[g�m��!ڞ���I�,���L�ҩh�o�!e�CSԾdP��2Y��(�����
�|�#���yT��|3+����V#���#q�f��7���]mt���]Q�_9���Av��UK�UI� {��YW���9�������m��Ty���R�Zס���r�H�      D   (  x���M�1���S����.{�,9���҈Ĝ�rw��R�d��E�Ϯ�� &EH��l|}�������[" =B9�P;H�5��Y�����W�T��y?_ک���������ۣk�I
+��	aAJD�\W2�H'̤�d��6fn�2pj\����/d����.�ZG�
����5�)�YJ2@+��aЁ�v��&���xH �>�F�	�&��$6#�
�B��) ��1	�'!��*"p�@YJ�u?F��zaC�)> +�j	u�	�B�N"�A ���?�Yk�O(�]��z�lk�=2�z�:�,B��S1��Ԅ�B��I4�.�k����<�"ílv�b�d�KV�Pǩ(�AK,� x+� {�<��K%����8:��R@�ڮ! �$�l��h	u�jF�T��y��dF��v�`t�u�ۀ3�t������;�Q���2n=������ T:[&�X�I�p���$��Q���/��b�J��SWe�g�O
�X�֎�k�m�]Z��b}�?����'��z/OyY�?#��k      F   �   x����
�0F�{�"/�K��Oc6q�*�ɥ�
�5B��M'A��z���@?-Y���A�+��h߰(1Q��LAd����W�i,�ۘ�5����g�ő�Nտen#���]�p�*�6�@^
t��'IwuH���	�!����x&D|�(:�      H   �   x�3��*M�S8��(��3��+H2R+srR���s9��JR�RR�8��LuLu�ͬM�L��L,�p�sq:'��+�^�^
�$,�W�	g��������1.q.cN�ļ�����Ԭ�b�0O��C�#1%73�K+C=3#��Ĺb���� �T�     