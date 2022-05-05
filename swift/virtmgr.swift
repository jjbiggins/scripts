import Foundation
import Virtualization


guard CommandLine.argc == 3 else {
    printUsageAndExit()
}

let kernelURL = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: false)
let initialRamdiskURL  = URL(fileURLWithPath: CommandLine.arguments[2], isDirectory: false)

let configuration = VZVirtualMachineConfiguration()
configuration.cpuCount = 2
configuration.memorySize = 2 * 1024 * 1024 * 1024 // 2GiB
configuration.serialPorts = [ createConsoleConfiguration() ]
configuration.bootLoader = createBootLoader(kernelURL: kernelURL, initialRamdiskURL: initialRamdiskURL)

do {
    try configuration.validate()
} catch {
    print("Failed to validate VM configurations \(error)")
    exit(EXIT_FAILURE)
}

let virtualMachine = VZVirtualMachine(configuration: configuration)

let delegate = Delegate()
virtualMachine.start { (result) in
                      if case let .failure(error) = result {
                        print("Failre to start VM \(error)")
                        exit(EXIT_FAILURE)
                }
}

RunLoop.main.run(until: Date.distantFuture)
class Delegate: NSObject {
}

extension Delegate:VZVirtualMachineDelegate {
    func guestDidStop(_ virtualMachine: VZVirtualMachine) {
        print("The guest shut down. Exiting....")
        exit(EXIT_FAILURE)
    }
}


/// Creates a Linux bootloader with the given kernel and initial ramdisk.
func createBootLoader(kernelURL: URL, initialRamdiskURL: URL) -> VZBootLoader {
    let bootLoader = VZLinuxBootLoader(kernelURL: kernelURL)
    bootLoader.initialRamdiskURL = initialRamdiskURL

    let kernelCommandLineArguments = [
        // Use the first virtio console device as system console.
        "console=hvc0",
        // Stop in the initial ramdisk before attempting to transition to the root file system.

        "rd.break=initqueue"
    ]

    bootLoader.commandLine = kernelCommandLineArguments.joined(separator: " ")

    return bootLoader
}

/// Creates a serial configuration object for a virtio console device,
/// and attaches it to stdin and stdout.
func createConsoleConfiguration() -> VZSerialPortConfiguration {
    let consoleConfiguration = VZVirtioConsoleDeviceSerialPortConfiguration()

    let inputFileHandle = FileHandle.standardInput
    let outputFileHandle = FileHandle.standardOutput

    // Put stdin into raw mode, disabling local echo, input canonicalization,
    // and CR-NL mapping.
    var attributes = termios()
    tcgetattr(inputFileHandle.fileDescriptor, &attributes)
    attributes.c_iflag &= ~tcflag_t(ICRNL)
    attributes.c_lflag &= ~tcflag_t(ICANON | ECHO)
    tcsetattr(inputFileHandle.fileDescriptor, TCSANOW, &attributes)

    let stdioAttachment = VZFileHandleSerialPortAttachment(
                            fileHandleForReading: inputFileHandle,                       fileHandleForWriting: outputFileHandle)

    consoleConfiguration.attachment = stdioAttachment

    return consoleConfiguration
}


func printUsageAndExit() -> Never {
    print("Usage: \(CommandLine.arguments[0]) <kernel-path> <initial-ramdisk-path>")
    exit(EX_USAGE)
}



