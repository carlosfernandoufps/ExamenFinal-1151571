CREATE TABLE `connectiontoken`
(
`id` INT NOT NULL AUTO_INCREMENT,
`host` VARCHAR(200) NULL COMMENT 'Corresponde a la dirección del servidor de base de
datos',
`userdb` VARCHAR(50) NULL COMMENT 'Corresponde al nombre del usuario de conexión a
la base de datos',
`pass` VARCHAR(100) NULL,
`db` VARCHAR(50) NULL COMMENT 'Corresponde al nombre de la base de datos',
`token` VARCHAR(50) NULL COMMENT 'Define el token que sera utilizado para realizar la
busqueda de los datos de conexión a la base de datos. Este token sera único y utilizado para la
conexión',
`port` SMALLINT NULL COMMENT 'Define el puerto utilizado para la conexión al servidor de
base de datos',
`user` INT NULL,
`state` SMALLINT NULL,
`type` VARCHAR(20) NULL COMMENT 'Define el tipo de driver a utilizar en la base de datos',
CONSTRAINT `PK_connectiontoken` PRIMARY KEY (`id` ASC)
)
COMMENT = 'Almacena la información del Token de Conexión a al base de datos. Este proceso se
realiza por cada conexión que se realice a cada base de datos para ser utilizada y enviarla al reporte.';
CREATE TABLE `reporte`
(
`id` INT NOT NULL AUTO_INCREMENT,
`file` VARCHAR(100) NULL COMMENT 'Almacena el nombre del archivo jasper a utilizar',
`conexion` INT NULL,
`datecreate` TIMESTAMP NULL,
`state` VARCHAR(50) NULL COMMENT 'Define el estado del reporte',
`description` VARCHAR(500) NULL,
`name` VARCHAR(200) NULL,
CONSTRAINT `PK_reporte` PRIMARY KEY (`id` ASC)
)
COMMENT = 'Almacena la información de los hosteados en el sistema';
CREATE TABLE `rol`
(
`id` INT NOT NULL AUTO_INCREMENT,
`description` VARCHAR(100) NULL COMMENT 'Almacena la información del rol',
CONSTRAINT `PK_rol` PRIMARY KEY (`id` ASC)
)
COMMENT = 'Almacena la información de los roles del sistema';
CREATE TABLE `seguimiento`
(
`id` INT NOT NULL AUTO_INCREMENT,
`report` INT NULL,
`dategenerate` TIMESTAMP NULL,
`state` SMALLINT NULL,
`result` VARCHAR(500) NULL COMMENT 'Almacena el resultado de la consulta realizada al
servidor',
`detailrequest` VARCHAR(1000) NULL COMMENT 'Almacena los datos de las variables
ingresadas',
`type` VARCHAR(10) NULL COMMENT 'Define el tipo de generación, si fue xls o pdf. ',
`filegenerate` VARCHAR(100) NULL COMMENT 'Define el nombre del archivo generado',
CONSTRAINT `PK_seguimiento` PRIMARY KEY (`id` ASC)
)
COMMENT = 'Almacena información acerca del uso de los reportes';
CREATE TABLE `typedb`
(
`id` VARCHAR(20) NOT NULL,
`description` VARCHAR(100) NULL,
`driver` VARCHAR(200) NULL COMMENT 'Define los datos del driver',
`aditional` VARCHAR(500) NULL COMMENT 'Define los valores adicionales del Driver',
CONSTRAINT `PK_typedb` PRIMARY KEY (`id` ASC)
)
COMMENT = 'Almacena la información de los distintos tipos de conexión que soporta el sistema';
CREATE TABLE `usuario`
(
`id` INT NOT NULL AUTO_INCREMENT,
`usuario` VARCHAR(20) NULL COMMENT 'Define el usuario utilizado en el sistema, el cual
no puede ser cambiado porque genera estructuras de datos y demas.',
`email` VARCHAR(100) NULL,
`pass` VARCHAR(50) NULL,
`role` INT NULL,
`state` SMALLINT NULL COMMENT 'Define el estado del usuario, que puede ser sin activar,
bloqueado u otro estado disponible.',
CONSTRAINT `PK_usuario` PRIMARY KEY (`id` ASC)
)
COMMENT = 'Almacena la información de los usuarios del sistema';
/* Create Foreign Key Constraints */
ALTER TABLE `connectiontoken`
ADD CONSTRAINT `FK_connectiontoken_typedb`
FOREIGN KEY (`type`) REFERENCES `typedb` (`id`) ON DELETE Restrict ON UPDATE Restrict;
ALTER TABLE `connectiontoken`
ADD CONSTRAINT `FK_connectiontoken_usuario`
FOREIGN KEY (`user`) REFERENCES `usuario` (`id`) ON DELETE Restrict ON UPDATE Restrict;
ALTER TABLE `reporte`
ADD CONSTRAINT `FK_reporte_connectiontoken`
FOREIGN KEY (`conexion`) REFERENCES `connectiontoken` (`id`) ON DELETE Restrict ON
UPDATE Restrict;
ALTER TABLE `seguimiento`
ADD CONSTRAINT `FK_seguimiento_reporte`
FOREIGN KEY (`report`) REFERENCES `reporte` (`id`) ON DELETE Restrict ON UPDATE
Restrict;
ALTER TABLE `usuario`
ADD CONSTRAINT `FK_usuario_rol`
FOREIGN KEY (`role`) REFERENCES `rol` (`id`) ON DELETE Restrict ON UPDATE Cascade;