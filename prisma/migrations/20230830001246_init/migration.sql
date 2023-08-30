-- CreateTable
CREATE TABLE `Ciudad` (
    `ciudadId` INTEGER NOT NULL AUTO_INCREMENT,
    `ciudadNombre` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Ciudad_ciudadNombre_key`(`ciudadNombre`),
    PRIMARY KEY (`ciudadId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Field` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(300) NOT NULL,
    `precio` DOUBLE NOT NULL,
    `reservada` BOOLEAN NOT NULL DEFAULT false,
    `deporte` ENUM('futbol', 'tenis') NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `ciudadId` INTEGER NOT NULL,

    UNIQUE INDEX `Field_nombre_key`(`nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Field` ADD CONSTRAINT `Field_ciudadId_fkey` FOREIGN KEY (`ciudadId`) REFERENCES `Ciudad`(`ciudadId`) ON DELETE RESTRICT ON UPDATE CASCADE;
