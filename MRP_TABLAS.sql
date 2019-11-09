create database mrp_laboratorio;
use mrp_laboratorio;

create table proveedores (
   id                       int             not null auto_increment comment "Código Proveedor",
   nombre                   varchar(50)     not null                comment "Nombre Proveedor",
   constraint proveedores_pk primary key (id),
   constraint proveedores_uq_nombre unique (nombre)
) engine=innodb comment="Esta tabla contiene la información de proveedores";

create table materiales (
   familia		  varchar(50)	not null				comment "Familia a la cual pertenece la materia prima",
   id             int			not null auto_increment comment "Código Materia Prima",
   nombre         varchar(50)	not null				comment "Nombre Materia Prima",
   unidad         varchar(50)	not null				comment "Unidad",
   descripción    varchar(50)	not null				comment "Descripción",
   precio         int			not null				comment "Precio",
   lead_time      int		    not null				comment "Lead time establecido",
   pedido_min	  int	    	not null				comment "Pedido mínimo establecido (unidades)",
   proveedor_id	  int			not null				comment "Código del proveedor",
   constraint materiales_pk primary key (id),
   constraint materiales_uq_nombre unique (nombre),
   key materiales_proveedorid (proveedor_id),
   constraint materiales_fk_proveedores_id foreign key (proveedor_id)
   references proveedores (id) 
   on delete no action on update cascade
) engine=innodb comment="Esta tabla contiene la información de materia prima";

create table componentes (
	id				int			not null auto_increment	comment "Código de componente",nombre         varchar(50)	not null				comment "Nombre Materia Prima",
    nombre			varchar(50) not null				comment "Nombre del componente",
    unidad         	varchar(50)	not null				comment "Unidad",
    precio          int			not null				comment "Precio",
    mp_id		    int		    not null				comment "Código de materia prima necesaria",
	mp_nombre		varchar(50) not null				comment "Nombre de materia prima necesaria",
    cantidad		int			not null				comment	"Cantidad de materia prima necesaria",
    constraint componentes_id primary key (id),
    constraint componentes_nombre unique (nombre),
	key componente_id (mp_id),
	constraint componentes_fk_id foreign key (id)
	references materiales (id), 
	key componentes_mp_nombre (mp_nombre),
	constraint componentes_fk_nombre foreign key (mp_nombre)
	references materiales (nombre)
)engine=innodb comment="Esta tabla contiene la información de clientes";

create table skus(
id				int				not null auto_increment comment "Código SKU",
nombre			varchar (50)	not null				comment "Nombre SKU",
lead_time		int				not null				comment "Lead time establecido de producción",
constraint skus_pk	primary key (id),
constraint skus_uq_nombre	unique(nombre)
) engine=innodb comment="Esta tabla contiene la información de SKU's";

create table cliente (
   id                       int             not null auto_increment comment "",
   nombre1                  varchar(50)     not null                comment "",
   nombre2                  varchar(50)     not null                comment "",
   apellido1                varchar(50)     not null                comment "",
   apellido2                varchar(50)     not null                comment "",
   constraint cliente_pk primary key (id)
) engine=innodb comment="Esta tabla contiene la información de clientes";

create table mps (
   id					int		not null auto_increment comment "Código SKU",
   nombre        		varchar(50)	not null				comment "Nombre SKU",
   scrap         		int	not null				        comment "Scrap",
   inventario_inicial  	int	not null				        comment "Inventario inicial",
   plan_produ         	int			not null				comment "Plan de producción",
   disponible     		int		    not null				comment "Disponible",
   despacho	  			int	    	not null				comment "Despacho",
   inventario_final	  	int			not null				comment "Inventario final",
   constraint mps_pk primary key (id),
   constraint mps_uq_nombre unique (nombre),
   key mps_id (id),
   constraint mps_fk_id foreign key (id)
   references skus (id), 
   key mps_nombre (nombre),
   constraint mps_fk_nombre foreign key (nombre)
   references skus (nombre) 
   on delete no action on update cascade
) engine=innodb comment="Esta tabla contiene la información de MPS";

create table bom(
id				int				not null auto_increment comment "Código BOM",
id_sku			int				not null				comment	"Código de sku respectivo al BOM",
componente_id	int				not null				comment "Código de componente",
materiaprima_id	int				not null				comment "Código de materia prima",
cantidad_mp 	int				not null				comment "Cantidad de esa materia prima necesaria",
cantidad_comp	int				not null				comment "Cantidad de componente necesario",
descripcion		varchar(50)		not null				comment "Para especificar la unidad en que se encuentra MP",
constraint bom_pk 		primary key (id),
key bom_id_sku (id_sku),
constraint bom_id_sku foreign key (id_sku)
references skus (id),
key bom_materiaprima_id	(materiaprima_id),
constraint bom_fk_materiaprima_id foreign key (materiaprima_id)
references materiales (id),
key bom_componente_id (componente_id),
constraint bom_fk_componente_id foreign key (componente_id)
references componentes (id)
) engine=InnoDB comment="Esta tabla contiene la información de BOM's";

create table mrp (
codigo_mp		int				not null 				comment "Código del material",
nombre_mp		varchar (50)	not null				comment "Nombre del material",
proveedor		varchar (50)	not null				comment	"Proveedor",
tamano_pedido	int				not null				comment "Tamano del pedido",
fecha_pedido	date			not null				comment "Fecha de colocación del pedido",
fecha_llegada	date			not null				comment "Fecha de llegada del pedido",
excepciones		varchar (100)	not null				comment "Reporte de excepciones",
key mrp_proveedor_nombre (proveedor),
constraint mrp_proveedor_nombre foreign key(proveedor)
references proveedores (nombre),
key mrp_codigo_materiaprima (codigo_mp),
constraint mrp_codigo_materiaprima foreign key (codigo_mp)
references materiales (id),
key mrp_nombre_materiaprima (nombre_mp),
constraint mrp_nombre_materiaprima foreign key (nombre_mp)
references materiales (nombre)
) engine=InnoDB comment= "Esta tabla contiene el reporte de MRP"