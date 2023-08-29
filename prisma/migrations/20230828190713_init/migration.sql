/*
  Warnings:

  - You are about to drop the column `cityId` on the `Field` table. All the data in the column will be lost.
  - You are about to drop the `City` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `ciudadId` to the `Field` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Field` DROP FOREIGN KEY `Field_cityId_fkey`;

-- AlterTable
ALTER TABLE `Field` DROP COLUMN `cityId`,
    ADD COLUMN `ciudadId` INTEGER NOT NULL;

-- DropTable
DROP TABLE `City`;

-- CreateTable
CREATE TABLE `Ciudad` (
    `ciudadId` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Ciudad_nombre_key`(`nombre`),
    PRIMARY KEY (`ciudadId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Field` ADD CONSTRAINT `Field_ciudadId_fkey` FOREIGN KEY (`ciudadId`) REFERENCES `Ciudad`(`ciudadId`) ON DELETE RESTRICT ON UPDATE CASCADE;
