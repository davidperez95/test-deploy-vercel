/*
  Warnings:

  - Added the required column `cityId` to the `Field` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Field` ADD COLUMN `cityId` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `City` (
    `cityId` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `City_nombre_key`(`nombre`),
    PRIMARY KEY (`cityId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Field` ADD CONSTRAINT `Field_cityId_fkey` FOREIGN KEY (`cityId`) REFERENCES `City`(`cityId`) ON DELETE RESTRICT ON UPDATE CASCADE;
