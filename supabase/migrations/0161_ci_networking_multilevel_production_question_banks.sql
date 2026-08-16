-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0161_ci_networking_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Networking
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Technician I — Entry Level                 -> Level 1
--   Technician II — Experienced                    -> Level 2
--   Technician III — Lead Technician                 -> Level 3
--   Service Technician                   -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess networking fundamentals,
-- addressing, switching, routing, VLANs, wireless, PoE, network services,
-- troubleshooting, architecture, security, and progressively higher networking judgment.
-- ============================================================================

begin;

create temporary table _seed_ci_networking_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_networking_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a computer network?',
  '[{"key":"A","text":"To allow connected devices to communicate and share data or services"},{"key":"B","text":"To provide line-voltage power to every device"},{"key":"C","text":"To replace all system documentation"},{"key":"D","text":"To amplify audio signals"}]'::jsonb,
  '["A"]'::jsonb,
  'A network connects devices so they can exchange information and access shared services.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the primary function of an Ethernet switch?',
  '[{"key":"A","text":"To connect network devices and forward traffic between them"},{"key":"B","text":"To convert speaker-level audio"},{"key":"C","text":"To control lighting loads directly"},{"key":"D","text":"To provide video scaling"}]'::jsonb,
  '["A"]'::jsonb,
  'An Ethernet switch connects devices on a local network and forwards traffic to the appropriate destination.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the primary function of a router?',
  '[{"key":"A","text":"To move network traffic between different networks"},{"key":"B","text":"To terminate every category cable"},{"key":"C","text":"To amplify wireless signals only"},{"key":"D","text":"To control loudspeaker polarity"}]'::jsonb,
  '["A"]'::jsonb,
  'A router directs traffic between separate networks, such as a local network and the internet.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is an IP address used for?',
  '[{"key":"A","text":"To identify a device or interface on an IP network"},{"key":"B","text":"To identify the physical color of a network cable"},{"key":"C","text":"To measure speaker impedance"},{"key":"D","text":"To assign lighting scenes"}]'::jsonb,
  '["A"]'::jsonb,
  'An IP address provides a logical network identity used to send traffic to the correct device or interface.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What does DHCP commonly do on a network?',
  '[{"key":"A","text":"Automatically assigns IP configuration information to network devices"},{"key":"B","text":"Measures cable length"},{"key":"C","text":"Encrypts every application automatically"},{"key":"D","text":"Provides electrical grounding"}]'::jsonb,
  '["A"]'::jsonb,
  'DHCP commonly provides devices with IP addresses and other basic network configuration automatically.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is the purpose of a wireless access point?',
  '[{"key":"A","text":"To provide wireless devices access to the network"},{"key":"B","text":"To replace every wired switch"},{"key":"C","text":"To provide branch-circuit power"},{"key":"D","text":"To convert video signals to audio"}]'::jsonb,
  '["A"]'::jsonb,
  'A wireless access point allows compatible wireless clients to connect to the network.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What does a subnet mask help determine?',
  '[{"key":"A","text":"Which portion of an IP address identifies the local network and which portion identifies the host"},{"key":"B","text":"Which cable color should be used"},{"key":"C","text":"The maximum loudspeaker level"},{"key":"D","text":"The mounting height of a device"}]'::jsonb,
  '["A"]'::jsonb,
  'A subnet mask helps devices determine whether another IP address is on the local network or must be reached through a router.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why is network device labeling important?',
  '[{"key":"A","text":"It helps identify devices, ports, cables, locations, and network relationships consistently"},{"key":"B","text":"It increases network bandwidth"},{"key":"C","text":"It automatically assigns IP addresses"},{"key":"D","text":"It eliminates the need for testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent labeling supports installation, troubleshooting, documentation, and future service.'
),
(
  9,
  'multiple_choice',
  'application',
  'A technician connects a network device to a switch but the device shows no network link. What should be checked first?',
  '[{"key":"A","text":"The cable connection, switch port status, device network port, and basic physical-link indicators"},{"key":"B","text":"The room lighting scene"},{"key":"C","text":"The speaker polarity"},{"key":"D","text":"The display aspect ratio"}]'::jsonb,
  '["A"]'::jsonb,
  'A missing link should first be investigated at the physical connection and port level.'
),
(
  10,
  'multiple_choice',
  'application',
  'A new device is configured with the same static IP address as an existing device. What problem can this create?',
  '[{"key":"A","text":"An IP address conflict that can cause unreliable or failed communication"},{"key":"B","text":"Higher network speed"},{"key":"C","text":"Automatic network segmentation"},{"key":"D","text":"Improved wireless coverage"}]'::jsonb,
  '["A"]'::jsonb,
  'Two devices using the same IP address can interfere with each other and prevent reliable network communication.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician needs to connect several wired devices in the same equipment rack. Which device is commonly used?',
  '[{"key":"A","text":"An Ethernet switch"},{"key":"B","text":"An audio amplifier"},{"key":"C","text":"A lighting dimmer"},{"key":"D","text":"A video display"}]'::jsonb,
  '["A"]'::jsonb,
  'A network switch provides multiple Ethernet ports for connecting devices on the local network.'
),
(
  12,
  'multiple_choice',
  'application',
  'A networked device is set for DHCP but receives no usable IP configuration. What should the technician verify?',
  '[{"key":"A","text":"That the device has network link and can reach the network service providing DHCP"},{"key":"B","text":"That the device is connected to a speaker output"},{"key":"C","text":"That the room keypad is programmed"},{"key":"D","text":"That the display is on the correct HDMI input"}]'::jsonb,
  '["A"]'::jsonb,
  'DHCP requires basic connectivity between the client device and the network service assigning addresses.'
),
(
  13,
  'multiple_choice',
  'application',
  'A device has the correct IP address but cannot communicate with devices outside its local subnet. What basic setting should be checked?',
  '[{"key":"A","text":"The default gateway"},{"key":"B","text":"The cable label color"},{"key":"C","text":"The audio gain setting"},{"key":"D","text":"The fixture wattage"}]'::jsonb,
  '["A"]'::jsonb,
  'The default gateway is commonly used to reach destinations outside the local subnet.'
),
(
  14,
  'multiple_choice',
  'application',
  'A technician is connecting a networked control processor according to a project drawing. What is the BEST practice?',
  '[{"key":"A","text":"Connect it to the documented network location or switch port and verify its intended IP configuration"},{"key":"B","text":"Use any available connection and leave documentation unchanged"},{"key":"C","text":"Assign a random IP address"},{"key":"D","text":"Connect it directly to a loudspeaker"}]'::jsonb,
  '["A"]'::jsonb,
  'Network installation should follow documented topology and addressing requirements.'
),
(
  15,
  'multiple_choice',
  'application',
  'A wireless device has weak connectivity in one room. What should the technician verify first?',
  '[{"key":"A","text":"Signal strength, access-point location, interference, distance, and whether the device is associated with the intended wireless network"},{"key":"B","text":"The speaker impedance"},{"key":"C","text":"The lighting load type"},{"key":"D","text":"The display resolution"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic wireless troubleshooting starts with coverage, interference, distance, and correct association.'
),
(
  16,
  'multiple_choice',
  'application',
  'A switch port is labeled for a specific room device. What should the technician do when connecting the device?',
  '[{"key":"A","text":"Use the documented port assignment and verify the label matches the installed device and cable"},{"key":"B","text":"Use any port and remove the label"},{"key":"C","text":"Move the cable to a different switch without documentation"},{"key":"D","text":"Ignore the network drawing"}]'::jsonb,
  '["A"]'::jsonb,
  'Following documented port assignments improves accuracy and future serviceability.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician installs a new networked controller. The Ethernet link light is on, but the controller cannot be reached from another device on the same network. What is the BEST next step?',
  '[{"key":"A","text":"Verify the controller IP address, subnet mask, and whether the other device is configured for the same local network"},{"key":"B","text":"Replace the Ethernet switch immediately"},{"key":"C","text":"Replace every network cable in the project"},{"key":"D","text":"Disable all wireless access points"}]'::jsonb,
  '["A"]'::jsonb,
  'With physical link present, the next step is to verify basic IP configuration and local network addressing.'
),
(
  18,
  'scenario',
  'scenario',
  'A newly installed device works when connected directly to one switch port but not at its intended room location. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Compare the known-good connection with the room cable path, terminations, patching, and intended switch port to isolate the physical-path problem"},{"key":"B","text":"Change the device IP address repeatedly"},{"key":"C","text":"Replace the router first"},{"key":"D","text":"Disable DHCP"}]'::jsonb,
  '["A"]'::jsonb,
  'A successful known-good connection helps isolate the fault to the room cabling or patching path.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician adds a device with a static IP address and immediately another existing device becomes unreachable. What is the BEST first response?',
  '[{"key":"A","text":"Check whether the new device is using an IP address already assigned to another device"},{"key":"B","text":"Increase wireless transmit power"},{"key":"C","text":"Replace the router"},{"key":"D","text":"Change every device to DHCP without review"}]'::jsonb,
  '["A"]'::jsonb,
  'The timing strongly suggests an address conflict and should be checked before making broader network changes.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes installation of several networked devices in a rack. Before handoff, what is the BEST basic verification?',
  '[{"key":"A","text":"Confirm physical links, documented port assignments, device IP configuration, basic communication, and cable/device labeling"},{"key":"B","text":"Confirm only that every device has power"},{"key":"C","text":"Remove all labels after testing"},{"key":"D","text":"Change all IP addresses after documentation is complete"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic network readiness includes physical connectivity, correct addressing, communication, and accurate documentation.'
);

create temporary table _seed_ci_networking_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_networking_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of DNS on an IP network?',
  '[{"key":"A","text":"To translate host names into IP addresses and support name-based network access"},{"key":"B","text":"To assign switch port numbers"},{"key":"C","text":"To provide electrical grounding"},{"key":"D","text":"To measure cable resistance"}]'::jsonb,
  '["A"]'::jsonb,
  'DNS allows devices and users to reference network resources by name rather than only by numeric IP address.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is a VLAN commonly used for?',
  '[{"key":"A","text":"To logically separate groups of devices or traffic on shared network infrastructure"},{"key":"B","text":"To increase electrical voltage"},{"key":"C","text":"To terminate fiber connectors"},{"key":"D","text":"To replace IP addressing"}]'::jsonb,
  '["A"]'::jsonb,
  'A VLAN creates logical network separation while allowing devices to share physical switching infrastructure.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of PoE in a network installation?',
  '[{"key":"A","text":"To provide compatible devices with electrical power over Ethernet cabling while also supporting network communication"},{"key":"B","text":"To increase internet speed automatically"},{"key":"C","text":"To assign static IP addresses"},{"key":"D","text":"To encrypt every Ethernet frame"}]'::jsonb,
  '["A"]'::jsonb,
  'Power over Ethernet can deliver both network connectivity and device power over compatible Ethernet infrastructure.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What does network bandwidth describe?',
  '[{"key":"A","text":"The amount of data a network link or path can carry over time"},{"key":"B","text":"The physical width of an Ethernet cable"},{"key":"C","text":"The number of switch labels"},{"key":"D","text":"The voltage supplied by a router"}]'::jsonb,
  '["A"]'::jsonb,
  'Bandwidth describes the data-carrying capacity of a network connection or path.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is latency in networking?',
  '[{"key":"A","text":"The delay between sending data and its arrival or response"},{"key":"B","text":"The amount of PoE power available"},{"key":"C","text":"The number of devices on a switch"},{"key":"D","text":"The physical length of a rack"}]'::jsonb,
  '["A"]'::jsonb,
  'Latency is the time delay experienced as data moves through the network.'
),
(
  6,
  'multiple_choice',
  'application',
  'A networked device has a static IP address outside the subnet used by the rest of the local devices. What is the BEST correction?',
  '[{"key":"A","text":"Assign the device an appropriate IP address and subnet configuration for the intended network"},{"key":"B","text":"Replace the switch"},{"key":"C","text":"Increase wireless transmit power"},{"key":"D","text":"Disable the default gateway"}]'::jsonb,
  '["A"]'::jsonb,
  'Devices must use addressing that matches the intended subnet unless routing has been deliberately designed otherwise.'
),
(
  7,
  'multiple_choice',
  'application',
  'A PoE-powered access point does not power up when connected to a switch. What should the technician verify?',
  '[{"key":"A","text":"That the switch port supports the required PoE standard and has sufficient available power budget"},{"key":"B","text":"That DNS is disabled"},{"key":"C","text":"That the router uses a public IP address"},{"key":"D","text":"That the access point has a static hostname"}]'::jsonb,
  '["A"]'::jsonb,
  'PoE devices depend on compatible power standards and sufficient switch power capacity.'
),
(
  8,
  'multiple_choice',
  'application',
  'A client reports that wired devices work normally but wireless devices in one area frequently disconnect. What should be reviewed first?',
  '[{"key":"A","text":"Access-point placement, signal strength, interference, channel use, client density, and roaming conditions in that area"},{"key":"B","text":"The router power cord only"},{"key":"C","text":"Every Ethernet patch cable in the building"},{"key":"D","text":"All device IP addresses regardless of location"}]'::jsonb,
  '["A"]'::jsonb,
  'A localized wireless problem should be investigated through coverage, interference, channel planning, and client behavior.'
),
(
  9,
  'multiple_choice',
  'application',
  'A device can communicate with local devices but cannot reach internet resources by name. Which service should be checked?',
  '[{"key":"A","text":"DNS configuration and reachability"},{"key":"B","text":"PoE power budget"},{"key":"C","text":"Switch port labeling"},{"key":"D","text":"Wireless channel width only"}]'::jsonb,
  '["A"]'::jsonb,
  'If local IP communication works but name-based access fails, DNS is a primary service to verify.'
),
(
  10,
  'multiple_choice',
  'application',
  'A managed switch port is assigned to the wrong VLAN. What symptom can result?',
  '[{"key":"A","text":"The connected device may be placed on the wrong logical network and lose access to required services"},{"key":"B","text":"The Ethernet cable automatically changes category"},{"key":"C","text":"The device receives more PoE power"},{"key":"D","text":"Wireless signal strength increases"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect VLAN assignment can isolate a device from the network resources it is expected to reach.'
),
(
  11,
  'multiple_choice',
  'application',
  'A network switch has enough physical ports for new devices but several PoE devices fail to power. What additional capacity must be reviewed?',
  '[{"key":"A","text":"The switch PoE power budget and per-port power requirements"},{"key":"B","text":"The number of DNS records"},{"key":"C","text":"The router hostname"},{"key":"D","text":"The subnet mask length only"}]'::jsonb,
  '["A"]'::jsonb,
  'Available port count does not guarantee sufficient power capacity for all connected PoE devices.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician is adding a managed switch to an existing project. What information should be confirmed before configuration?',
  '[{"key":"A","text":"Management IP requirements, VLANs, uplink design, port assignments, PoE needs, and documentation standards"},{"key":"B","text":"Only the rack-unit position"},{"key":"C","text":"Only the switch manufacturer"},{"key":"D","text":"Only the number of LEDs on the front panel"}]'::jsonb,
  '["A"]'::jsonb,
  'A managed switch should be configured according to the intended addressing, segmentation, uplink, power, and port design.'
),
(
  13,
  'multiple_choice',
  'application',
  'A device receives an IP address from DHCP but cannot reach its intended controller on another subnet. What should be reviewed?',
  '[{"key":"A","text":"The assigned IP configuration, default gateway, routing, VLAN placement, and any access restrictions between the networks"},{"key":"B","text":"Only the Ethernet cable color"},{"key":"C","text":"Only the PoE wattage"},{"key":"D","text":"The device mounting height"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-subnet communication depends on correct addressing, routing, segmentation, and network policy.'
),
(
  14,
  'multiple_choice',
  'application',
  'A technician changes a switch port configuration and several connected systems stop communicating. What is the BEST response?',
  '[{"key":"A","text":"Compare the changed port settings with the documented VLAN, uplink, trunk, access, and device requirements before making further changes"},{"key":"B","text":"Factory-reset every network device"},{"key":"C","text":"Replace the router immediately"},{"key":"D","text":"Randomly move cables to other ports"}]'::jsonb,
  '["A"]'::jsonb,
  'Configuration changes should be compared against the documented network design to isolate the impact.'
),
(
  15,
  'scenario',
  'scenario',
  'A residential network has wired automation controllers, wireless mobile devices, cameras, and streaming equipment. Users report slow performance only during heavy video use. What is the BEST first analysis?',
  '[{"key":"A","text":"Review bandwidth utilization, uplinks, switching capacity, wireless load, and whether video traffic is saturating a shared path"},{"key":"B","text":"Change every device IP address"},{"key":"C","text":"Replace all wireless access points without measuring traffic"},{"key":"D","text":"Disable DHCP"}]'::jsonb,
  '["A"]'::jsonb,
  'Performance problems during high traffic should be evaluated against actual network capacity and shared bottlenecks.'
),
(
  16,
  'scenario',
  'scenario',
  'A new camera powers from PoE and receives an IP address, but it cannot communicate with the recorder located on a different VLAN. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Verify the camera VLAN, addressing, gateway, inter-VLAN routing or policy, and recorder network placement"},{"key":"B","text":"Replace the camera power supply"},{"key":"C","text":"Disable PoE"},{"key":"D","text":"Change every switch port to the same VLAN without reviewing the design"}]'::jsonb,
  '["A"]'::jsonb,
  'Because power and local addressing are working, the next focus should be segmentation and routed communication between the required networks.'
),
(
  17,
  'scenario',
  'scenario',
  'A client reports that wireless performance is excellent near one access point but poor in an adjacent room despite strong signal strength. What should be investigated?',
  '[{"key":"A","text":"Interference, channel overlap, channel width, client behavior, roaming, and actual throughput rather than signal strength alone"},{"key":"B","text":"Only the access-point mounting color"},{"key":"C","text":"The DNS server name"},{"key":"D","text":"Every wired switch port"}]'::jsonb,
  '["A"]'::jsonb,
  'Strong signal does not guarantee good wireless performance when interference or channel-use problems are present.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician replaces a network switch and afterward several devices receive IP addresses but some integrated systems no longer communicate. What is the BEST next step?',
  '[{"key":"A","text":"Compare the replacement switch configuration with the original VLANs, uplinks, port assignments, trunks, PoE settings, and management configuration"},{"key":"B","text":"Replace all client devices"},{"key":"C","text":"Disable VLANs permanently"},{"key":"D","text":"Change every device to a public IP address"}]'::jsonb,
  '["A"]'::jsonb,
  'A replacement switch must reproduce the network functions required by the original design, not merely provide physical connectivity.'
),
(
  19,
  'scenario',
  'scenario',
  'A project has intermittent connectivity to several networked devices connected through the same access switch. Other parts of the network are stable. What is the BEST approach?',
  '[{"key":"A","text":"Review the affected switch, uplink, port errors, cabling, power, VLAN configuration, traffic levels, and logs to isolate the common failure point"},{"key":"B","text":"Replace every device on the network"},{"key":"C","text":"Change all subnet masks"},{"key":"D","text":"Disable the router"}]'::jsonb,
  '["A"]'::jsonb,
  'A group of failures sharing common infrastructure should be investigated through that shared switch and uplink path.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician is preparing a network for handoff after switches, access points, controllers, and other integrated devices have been configured. What is the BEST readiness check?',
  '[{"key":"A","text":"Verify addressing, VLANs, uplinks, PoE capacity, wired and wireless connectivity, required inter-device communication, labeling, and current documentation"},{"key":"B","text":"Confirm only that internet access works"},{"key":"C","text":"Remove switch-port labels after testing"},{"key":"D","text":"Factory-reset the managed switches"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete handoff should confirm both network infrastructure and the communication paths required by the integrated systems.'
);

create temporary table _seed_ci_networking_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_networking_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is network architecture important in a larger integrated system?',
  '[{"key":"A","text":"Switching, routing, addressing, segmentation, wireless coverage, services, and endpoint requirements must work together as one coordinated design"},{"key":"B","text":"It allows devices to be added without documentation"},{"key":"C","text":"It eliminates the need for IP planning"},{"key":"D","text":"It guarantees every device will work on factory defaults"}]'::jsonb,
  '["A"]'::jsonb,
  'Larger integrated systems depend on coordinated network architecture across infrastructure, services, and endpoints.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of inter-VLAN routing?',
  '[{"key":"A","text":"To allow controlled communication between devices on different VLANs"},{"key":"B","text":"To provide PoE power"},{"key":"C","text":"To increase cable category"},{"key":"D","text":"To replace DHCP"}]'::jsonb,
  '["A"]'::jsonb,
  'Devices on separate VLANs require routing when communication between those logical networks is intended.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is multicast management important on networks carrying some integrated-system traffic?',
  '[{"key":"A","text":"Uncontrolled multicast can consume bandwidth and affect devices that do not need the traffic"},{"key":"B","text":"Multicast automatically increases PoE capacity"},{"key":"C","text":"Multicast is used only for internet browsing"},{"key":"D","text":"Multicast removes the need for switches"}]'::jsonb,
  '["A"]'::jsonb,
  'Multicast traffic should be managed so it reaches intended recipients without unnecessarily loading the rest of the network.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why should network capacity be evaluated during system design?',
  '[{"key":"A","text":"Switching, uplinks, routing, wireless, PoE, and services must support current traffic, devices, and foreseeable expansion"},{"key":"B","text":"Capacity matters only for rack size"},{"key":"C","text":"Every network has unlimited bandwidth"},{"key":"D","text":"Capacity affects only device labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Network infrastructure should support present requirements and reasonable future growth.'
),
(
  5,
  'multiple_choice',
  'application',
  'A project adds many cameras and AV-over-network endpoints after the original network design is complete. What should be reviewed first?',
  '[{"key":"A","text":"Switch capacity, uplink bandwidth, multicast requirements, PoE budget, VLAN design, routing, and documentation"},{"key":"B","text":"Only the number of available rack spaces"},{"key":"C","text":"Only the device hostnames"},{"key":"D","text":"Only the internet service speed"}]'::jsonb,
  '["A"]'::jsonb,
  'Adding high-bandwidth or PoE endpoints can affect several parts of the network architecture.'
),
(
  6,
  'multiple_choice',
  'application',
  'A network uses separate VLANs for control, cameras, guest devices, and AV traffic. What is the BEST design practice?',
  '[{"key":"A","text":"Define which networks need to communicate, route only required traffic, and document the segmentation and access rules"},{"key":"B","text":"Allow all VLANs unrestricted access to each other by default"},{"key":"C","text":"Place every device on the same VLAN"},{"key":"D","text":"Use VLANs only as naming labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Segmentation is most useful when communication requirements and routing policy are deliberately defined.'
),
(
  7,
  'multiple_choice',
  'application',
  'A managed network is supporting an automation platform that must discover and control devices across multiple switches. What should be verified?',
  '[{"key":"A","text":"VLAN placement, required discovery behavior, multicast handling, routing, switch configuration, and endpoint addressing"},{"key":"B","text":"Only that every device has internet access"},{"key":"C","text":"Only the switch manufacturer"},{"key":"D","text":"That all ports use default settings"}]'::jsonb,
  '["A"]'::jsonb,
  'Discovery and control can depend on segmentation, multicast behavior, and consistent configuration across the network.'
),
(
  8,
  'multiple_choice',
  'application',
  'A wireless deployment has good coverage but poor performance when many clients are active. What should be evaluated?',
  '[{"key":"A","text":"Client density, channel reuse, airtime utilization, channel width, interference, access-point capacity, and uplinks"},{"key":"B","text":"Only signal strength"},{"key":"C","text":"Only DHCP lease duration"},{"key":"D","text":"Only the router hostname"}]'::jsonb,
  '["A"]'::jsonb,
  'Wireless performance is influenced by shared airtime and capacity, not just received signal level.'
),
(
  9,
  'multiple_choice',
  'application',
  'A network has intermittent packet loss affecting devices connected through one distribution switch. What should guide troubleshooting?',
  '[{"key":"A","text":"Review uplink errors, utilization, spanning-tree state, switch logs, cabling, VLAN configuration, and shared dependencies on that switch"},{"key":"B","text":"Replace every endpoint on the network"},{"key":"C","text":"Change all IP addresses"},{"key":"D","text":"Disable routing"}]'::jsonb,
  '["A"]'::jsonb,
  'A group of devices sharing one switch should be investigated through the common infrastructure and its uplinks.'
),
(
  10,
  'multiple_choice',
  'application',
  'A client needs remote access to supported systems without exposing the entire local network. What is the BEST design approach?',
  '[{"key":"A","text":"Use an approved secure remote-access method with defined authentication, authorization, segmentation, and limited access scope"},{"key":"B","text":"Open all router ports to the internet"},{"key":"C","text":"Disable all passwords"},{"key":"D","text":"Place every device directly on a public IP address"}]'::jsonb,
  '["A"]'::jsonb,
  'Remote support should provide only the access required while preserving network security and segmentation.'
),
(
  11,
  'multiple_choice',
  'application',
  'A project substitutes a different managed switch model late in the installation. What should be reviewed before deployment?',
  '[{"key":"A","text":"Port count, uplink capability, VLAN and multicast features, PoE capacity, management functions, configuration compatibility, and documentation impact"},{"key":"B","text":"Only the physical dimensions"},{"key":"C","text":"Only the purchase price"},{"key":"D","text":"Only the front-panel LED layout"}]'::jsonb,
  '["A"]'::jsonb,
  'A switch substitution can affect multiple network functions beyond simple Ethernet connectivity.'
),
(
  12,
  'scenario',
  'scenario',
  'A residence has automation, surveillance, AV-over-network, streaming, and guest wireless services. Video traffic causes intermittent control delays. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Measure traffic and utilization, identify shared bottlenecks, review VLAN and multicast behavior, inspect uplinks, and verify control traffic is not being overwhelmed"},{"key":"B","text":"Replace every controller"},{"key":"C","text":"Disable all cameras permanently"},{"key":"D","text":"Change every device to DHCP"}]'::jsonb,
  '["A"]'::jsonb,
  'The symptom suggests a network-capacity or traffic-management issue that should be measured and isolated.'
),
(
  13,
  'scenario',
  'scenario',
  'A networked AV system works on one switch but devices fail to discover each other when connected across two switches. What is the BEST systems-level response?',
  '[{"key":"A","text":"Review VLAN continuity, trunks, multicast or discovery requirements, switch configuration, and the inter-switch path"},{"key":"B","text":"Replace all AV endpoints"},{"key":"C","text":"Assign every device a public IP address"},{"key":"D","text":"Disable the second switch"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-switch discovery failures often point to segmentation, trunk, or multicast behavior on the shared network path.'
),
(
  14,
  'scenario',
  'scenario',
  'A facility has hundreds of PoE endpoints. Several devices reboot intermittently during peak operation. What is the BEST systems-level response?',
  '[{"key":"A","text":"Review switch PoE budgets, per-port power draw, power-supply capacity, redundancy, logs, and whether peak demand exceeds available power"},{"key":"B","text":"Change every IP address"},{"key":"C","text":"Disable VLANs"},{"key":"D","text":"Increase wireless transmit power"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent PoE reboots can result from power-budget or power-supply constraints under load.'
),
(
  15,
  'scenario',
  'scenario',
  'A multi-floor office has strong wireless signal throughout, but users experience slow roaming and interrupted calls while moving between floors. What should be evaluated?',
  '[{"key":"A","text":"Access-point overlap, roaming thresholds, channel plan, client behavior, controller settings, latency, and handoff performance"},{"key":"B","text":"Only internet bandwidth"},{"key":"C","text":"Only DHCP scope size"},{"key":"D","text":"Only switch port labels"}]'::jsonb,
  '["A"]'::jsonb,
  'Roaming quality depends on coordinated RF design, client behavior, and network configuration rather than signal strength alone.'
),
(
  16,
  'scenario',
  'scenario',
  'A project manager discovers that field switch-port assignments and VLAN labels no longer match the approved network drawings after several changes. Configuration work is about to begin. What is the BEST response?',
  '[{"key":"A","text":"Reconcile the actual ports, uplinks, device connections, VLAN assignments, labels, and drawings before final configuration"},{"key":"B","text":"Proceed using the old drawings"},{"key":"C","text":"Ignore field labels"},{"key":"D","text":"Move devices randomly until they communicate"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate configuration depends on alignment between physical topology and network documentation.'
),
(
  17,
  'scenario',
  'scenario',
  'A client needs cameras isolated from guest devices but still reachable by a recorder and selected support workstations. What is the BEST architecture?',
  '[{"key":"A","text":"Place cameras on an appropriate segmented network and allow only the required routed or policy-controlled communication to authorized systems"},{"key":"B","text":"Place cameras and guests on one unrestricted network"},{"key":"C","text":"Give every camera a public IP address"},{"key":"D","text":"Disable the recorder network interface"}]'::jsonb,
  '["A"]'::jsonb,
  'Segmentation should isolate device classes while permitting only the communication required for operation and support.'
),
(
  18,
  'scenario',
  'scenario',
  'An integrated system becomes unreliable after a firmware update to the core switch stack. What is the BEST response?',
  '[{"key":"A","text":"Review the change history, switch logs, feature behavior, VLANs, multicast, spanning tree, uplinks, and known firmware impacts before making unrelated endpoint changes"},{"key":"B","text":"Factory-reset every endpoint"},{"key":"C","text":"Replace all cabling"},{"key":"D","text":"Disable DHCP"}]'::jsonb,
  '["A"]'::jsonb,
  'A major infrastructure change immediately preceding failures should be investigated before altering unaffected endpoints.'
),
(
  19,
  'scenario',
  'scenario',
  'A core switch is being replaced on a large integrated project. What is the BEST preparation before removing the existing switch?',
  '[{"key":"A","text":"Capture configuration backups, VLANs, trunks, port assignments, management settings, PoE requirements, uplink design, firmware details, and a restoration plan"},{"key":"B","text":"Disconnect it before recording any configuration"},{"key":"C","text":"Change every endpoint IP address first"},{"key":"D","text":"Assume the replacement will discover all settings automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Core switch replacement should preserve the information needed to reproduce the required network behavior.'
),
(
  20,
  'scenario',
  'scenario',
  'A complex project includes managed switching, routing, multiple VLANs, wireless, PoE devices, cameras, AV-over-network, automation controllers, and remote support. What is the BEST pre-handoff technical review?',
  '[{"key":"A","text":"Verify physical topology, addressing, VLANs, routing, uplinks, multicast behavior, PoE capacity, wireless performance, required device communication, security, backups, and documentation end to end"},{"key":"B","text":"Confirm only that internet access works"},{"key":"C","text":"Skip integrated testing because each switch powers on"},{"key":"D","text":"Remove network documentation after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'A complex integrated network requires end-to-end validation of infrastructure, communication, performance, security, and documentation.'
);

create temporary table _seed_ci_networking_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_networking_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary responsibility of an expert-level networking practitioner in an integrated-systems environment?',
  '[{"key":"A","text":"To make system-level decisions that balance architecture, performance, segmentation, reliability, security, scalability, serviceability, and integration requirements"},{"key":"B","text":"To focus only on patch-cable installation"},{"key":"C","text":"To maximize internet bandwidth regardless of system needs"},{"key":"D","text":"To avoid documenting network decisions"}]'::jsonb,
  '["A"]'::jsonb,
  'Expert networking requires judgment across the complete network architecture rather than isolated device-level decisions.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why are network standards important across multiple integrated-system projects?',
  '[{"key":"A","text":"They create consistent expectations for addressing, segmentation, switching, wireless, security, naming, documentation, commissioning, and support"},{"key":"B","text":"They guarantee every site uses identical hardware"},{"key":"C","text":"They eliminate the need for testing"},{"key":"D","text":"They prevent all project-specific design decisions"}]'::jsonb,
  '["A"]'::jsonb,
  'Standards improve consistency and supportability while allowing controlled variation for project requirements.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should network architecture be evaluated for scalability before deployment?',
  '[{"key":"A","text":"Future endpoint counts, traffic, VLANs, PoE demand, wireless clients, integrations, and management requirements may exceed the original design"},{"key":"B","text":"Every network should be oversized without regard to requirements"},{"key":"C","text":"Scalability matters only for switch port count"},{"key":"D","text":"Scalability eliminates the need for documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'A scalable network can accommodate foreseeable growth without unnecessary redesign.'
),
(
  4,
  'multiple_choice',
  'application',
  'A client wants to expand an integrated network from one building to a multi-building campus. What is the BEST first design action?',
  '[{"key":"A","text":"Review current and future endpoint counts, traffic patterns, uplinks, routing, VLANs, fiber or copper infrastructure, PoE, wireless, resiliency, management, and documentation requirements"},{"key":"B","text":"Add access switches until connectivity fails"},{"key":"C","text":"Replace every endpoint first"},{"key":"D","text":"Extend the existing flat network without capacity analysis"}]'::jsonb,
  '["A"]'::jsonb,
  'Large expansions should begin with requirements and capacity analysis across the complete network architecture.'
),
(
  5,
  'multiple_choice',
  'application',
  'A portfolio includes many sites using the same integrated networking platform. What is the BEST enterprise-level implementation practice?',
  '[{"key":"A","text":"Use governed standards for addressing, VLANs, switch configuration, wireless design, firmware, backups, naming, documentation, monitoring, security, and approved exceptions"},{"key":"B","text":"Allow every installer to build unrelated network configurations"},{"key":"C","text":"Standardize only hardware brands"},{"key":"D","text":"Avoid keeping configuration backups because sites are similar"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeatable standards improve consistency, troubleshooting, training, deployment quality, and lifecycle support across sites.'
),
(
  6,
  'multiple_choice',
  'application',
  'A mission-critical facility cannot tolerate loss of all integrated-system communication from a single core-device failure. What design principle should be considered?',
  '[{"key":"A","text":"Reduce single points of failure through appropriate redundancy, resilient uplinks, segmentation, alternate paths, or localized functionality based on project requirements"},{"key":"B","text":"Place every system on one unmanaged switch"},{"key":"C","text":"Remove all local network services"},{"key":"D","text":"Use identical labels on redundant paths"}]'::jsonb,
  '["A"]'::jsonb,
  'Critical environments may require architectural measures that limit the impact of a single infrastructure failure.'
),
(
  7,
  'multiple_choice',
  'application',
  'A facility carries automation, surveillance, voice, AV-over-network, guest, and business traffic. What is the BEST system-level network strategy?',
  '[{"key":"A","text":"Define traffic classes, segmentation, routing, multicast behavior, bandwidth, QoS where justified, security boundaries, and documented communication requirements"},{"key":"B","text":"Place every device on one unrestricted flat network"},{"key":"C","text":"Give every endpoint a public IP address"},{"key":"D","text":"Treat all traffic as identical regardless of application"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex environments benefit from deliberate traffic segmentation and communication policy based on system requirements.'
),
(
  8,
  'multiple_choice',
  'application',
  'A client has inconsistent network performance across similar sites even though the same switch and access-point models are used. What is the BEST leadership-level response?',
  '[{"key":"A","text":"Compare topology, configuration standards, firmware, uplinks, VLANs, RF design, client density, traffic patterns, monitoring, and documentation across sites"},{"key":"B","text":"Increase wireless transmit power everywhere"},{"key":"C","text":"Replace all switches"},{"key":"D","text":"Assume identical hardware guarantees identical results"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent hardware does not guarantee consistent performance when architecture and configuration differ.'
),
(
  9,
  'multiple_choice',
  'application',
  'A major network-switch substitution is proposed late in a project. What is the BEST technical review?',
  '[{"key":"A","text":"Evaluate port density, uplink capacity, VLAN and multicast features, PoE, routing, redundancy, management, firmware, security, interoperability, configuration impact, and documentation before approval"},{"key":"B","text":"Approve it if the rack dimensions are similar"},{"key":"C","text":"Approve it if the brand is familiar"},{"key":"D","text":"Evaluate only the purchase price"}]'::jsonb,
  '["A"]'::jsonb,
  'A switch substitution can affect the complete network architecture and must be reviewed against system dependencies.'
),
(
  10,
  'multiple_choice',
  'application',
  'A lead technician is standardizing network deployments across multiple projects. What is the BEST approach?',
  '[{"key":"A","text":"Establish repeatable standards for topology, addressing, VLANs, port assignments, uplinks, PoE, wireless, naming, configuration backups, firmware, documentation, and commissioning"},{"key":"B","text":"Make every network unique to the installer"},{"key":"C","text":"Standardize only patch-cable colors"},{"key":"D","text":"Remove labels after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'Network standards should improve consistency, serviceability, documentation, and implementation quality.'
),
(
  11,
  'scenario',
  'scenario',
  'A campus network must support centralized management, shared services, and cross-building integrated systems while allowing each building to retain basic local operation if the core connection is lost. What is the BEST architecture?',
  '[{"key":"A","text":"Use a resilient architecture that combines centralized services and management with appropriate local switching, routing, services, and failure-domain separation"},{"key":"B","text":"Require every building to depend entirely on one central switch"},{"key":"C","text":"Remove local network functionality"},{"key":"D","text":"Build unrelated networks with no shared standards"}]'::jsonb,
  '["A"]'::jsonb,
  'The design should support centralized capability without making basic building operation entirely dependent on one failure point.'
),
(
  12,
  'scenario',
  'scenario',
  'A client wants to migrate several occupied sites from unmanaged flat networks to managed segmented networks. What is the BEST planning approach?',
  '[{"key":"A","text":"Inventory devices and dependencies, define addressing and VLAN strategy, identify discovery and multicast needs, plan switch configuration and migration phases, validate rollback, and document communication requirements"},{"key":"B","text":"Replace every switch immediately and troubleshoot afterward"},{"key":"C","text":"Assume all devices will work unchanged after segmentation"},{"key":"D","text":"Move all sites at once without a migration plan"}]'::jsonb,
  '["A"]'::jsonb,
  'Network segmentation changes communication paths and should be introduced through controlled planning and validation.'
),
(
  13,
  'scenario',
  'scenario',
  'A large facility uses high-bandwidth AV-over-network, cameras, automation, and business traffic across a shared switching environment. What is the BEST architecture strategy?',
  '[{"key":"A","text":"Define traffic requirements and engineer switching, uplinks, multicast, VLANs, QoS where appropriate, monitoring, and capacity so each service operates predictably"},{"key":"B","text":"Assume every switch port and uplink has unlimited capacity"},{"key":"C","text":"Disable segmentation"},{"key":"D","text":"Place every endpoint on a guest wireless network"}]'::jsonb,
  '["A"]'::jsonb,
  'Shared networks require deliberate capacity and traffic-management design for demanding integrated-system applications.'
),
(
  14,
  'scenario',
  'scenario',
  'A convention facility has many event spaces with temporary AV, control, guest, production, and streaming devices that change regularly. What is the BEST network approach?',
  '[{"key":"A","text":"Create a governed flexible architecture with defined VLANs, temporary-device onboarding procedures, addressing, access policy, bandwidth planning, monitoring, and documented change control"},{"key":"B","text":"Use one permanent unrestricted network for all temporary devices"},{"key":"C","text":"Allow event teams to change core switching without coordination"},{"key":"D","text":"Disable network monitoring during events"}]'::jsonb,
  '["A"]'::jsonb,
  'Dynamic event environments require flexibility within a controlled architecture and change process.'
),
(
  15,
  'scenario',
  'scenario',
  'A company wants one network standard deployed across fifty locations, but site sizes and system requirements vary. What is the BEST strategy?',
  '[{"key":"A","text":"Create a modular reference architecture with defined core standards, scalable switch and wireless tiers, VLAN templates, addressing conventions, security requirements, and controlled exceptions"},{"key":"B","text":"Install identical hardware quantities at every site"},{"key":"C","text":"Allow every site to invent a completely different network"},{"key":"D","text":"Standardize only SSID names"}]'::jsonb,
  '["A"]'::jsonb,
  'A reference architecture creates consistency while allowing controlled variation for site-specific requirements.'
),
(
  16,
  'scenario',
  'scenario',
  'A high-end project performs well, but service is difficult because switch configurations, VLAN assignments, IP plans, firmware versions, and credentials are poorly documented. What is the BEST design lesson?',
  '[{"key":"A","text":"Serviceability, documentation, configuration backups, naming, credential governance, firmware records, and maintainability are part of network quality"},{"key":"B","text":"Only current network speed matters"},{"key":"C","text":"Service teams should recreate configurations from memory"},{"key":"D","text":"Documentation should be deleted after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'A successful network must perform well and remain practical to support throughout its lifecycle.'
),
(
  17,
  'scenario',
  'scenario',
  'A project includes automation, AV, lighting, surveillance, access control, voice, and remote support. Each subsystem works independently, but cross-system communication is inconsistent. What is the BEST leadership-level approach?',
  '[{"key":"A","text":"Define network ownership, required communication paths, VLAN placement, routing, discovery and multicast requirements, security boundaries, addressing, documentation, and coordinated validation"},{"key":"B","text":"Assume independent subsystem operation guarantees successful integration"},{"key":"C","text":"Let every trade create overlapping network rules without coordination"},{"key":"D","text":"Move all devices to one VLAN"}]'::jsonb,
  '["A"]'::jsonb,
  'Multi-system environments require clearly defined network responsibilities and communication requirements across subsystem boundaries.'
),
(
  18,
  'scenario',
  'scenario',
  'A client expects the network to support increasing device counts, higher-resolution video, more wireless clients, and new integrated-system applications over many years. What is the BEST lifecycle strategy?',
  '[{"key":"A","text":"Evaluate backbone capacity, uplinks, switching, PoE, wireless, addressing, segmentation, management, firmware lifecycle, monitoring, and upgrade paths for foreseeable growth"},{"key":"B","text":"Design only for current minimum requirements"},{"key":"C","text":"Replace all infrastructure whenever one new device is added"},{"key":"D","text":"Assume current bandwidth will always be sufficient"}]'::jsonb,
  '["A"]'::jsonb,
  'Lifecycle planning should consider foreseeable growth where it materially affects infrastructure and supportability.'
),
(
  19,
  'scenario',
  'scenario',
  'A lead technician reviews several completed projects and finds repeated differences in VLAN numbering, IP ranges, port naming, switch configuration, wireless settings, backups, and documentation. What is the BEST organizational response?',
  '[{"key":"A","text":"Develop and enforce networking standards, templates, naming conventions, addressing plans, configuration baselines, backup practices, documentation requirements, and quality-review checkpoints"},{"key":"B","text":"Allow every project team to continue using unrelated methods"},{"key":"C","text":"Standardize only switch brands"},{"key":"D","text":"Stop reviewing completed projects"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring inconsistency is best addressed through shared standards and repeatable implementation practices.'
),
(
  20,
  'scenario',
  'scenario',
  'An organization is creating a new enterprise network standard after years of flat networks, inconsistent addressing, difficult service, undocumented switch configurations, unreliable wireless, and unpredictable integrated-system behavior. What is the BEST long-term strategy?',
  '[{"key":"A","text":"Create a governed networking framework covering reference architecture, switching, routing, VLANs, addressing, wireless, multicast, PoE, security, monitoring, configuration management, documentation, commissioning, serviceability, lifecycle planning, and controlled exceptions"},{"key":"B","text":"Select one switch manufacturer and allow all other practices to remain inconsistent"},{"key":"C","text":"Let each installer design and configure the network independently"},{"key":"D","text":"Focus only on reducing initial equipment cost"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature networking program requires an integrated technical framework that improves consistency, reliability, performance, security, and lifecycle management.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'd486b0a5-08c3-4d7c-aadd-1558b8faa9ab';
  v_l1_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
  v_l2_role_id uuid := '925c6250-5991-4179-afed-e47fa6a08a31';
  v_l3_role_id uuid := 'cefefd09-9d5b-4a67-87a9-830180b5a016';
  v_l4_role_id uuid := '34509f61-b041-4323-b927-cc8639bac9b4';
  v_assessment_id uuid;
  v_master_question_id uuid;
  v_assessment_question_id uuid;
  v_row record;
  v_level integer;
  v_role_template_id uuid;
  v_assessment_name text;
begin
  select i.id into v_industry_id
  from public.industries i
  where lower(i.slug) = 'custom-integration'
     or lower(i.name) = 'custom integration'
  order by case when lower(i.slug) = 'custom-integration' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Custom Integration industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Networking'
      and c.is_current = true
  ) then
    raise exception 'Current Networking Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l1_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician I — Entry Level'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Technician I — Entry Level L1 Networking requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician II — Experienced'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Technician II — Experienced L2 Networking requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l3_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician III — Lead Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Technician III — Lead Technician L3 Networking requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l4_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Service Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Service Technician L4 Networking requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 1
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 8
      and s.application_count = 8
      and s.scenario_count = 4
  ) then
    raise exception 'Expected current L1 assessment standard 20 / 8 / 8 / 4 not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 2
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 5
      and s.application_count = 9
      and s.scenario_count = 6
  ) then
    raise exception 'Expected current L2 assessment standard 20 / 5 / 9 / 6 not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 3
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 4
      and s.application_count = 7
      and s.scenario_count = 9
  ) then
    raise exception 'Expected current L3 assessment standard 20 / 4 / 7 / 9 not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 4
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 3
      and s.application_count = 7
      and s.scenario_count = 10
  ) then
    raise exception 'Expected current L4 assessment standard 20 / 3 / 7 / 10 not found';
  end if;

  -- ========================================================================
  -- Seed Level 1
  -- ========================================================================

  v_level := 1;
  v_role_template_id := v_l1_role_id;
  v_assessment_name := 'Networking — Level 1 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_ci_networking_l1_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
    limit 1;

    if v_master_question_id is null then
      insert into public.master_question_bank (
        industry_id,
        master_competency_template_id,
        domain,
        type,
        difficulty,
        prompt,
        options,
        points,
        critical_safety,
        practical_verification_required,
        status,
        version,
        is_current
      )
      values (
        v_industry_id,
        v_competency_id,
        'Networking',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
        false,
        'approved',
        1,
        true
      )
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Networking L1 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_l1_role_id
    )
    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
    limit 1;

    if v_assessment_question_id is null then
      insert into public.assessment_questions (
        assessment_id,
        master_competency_template_id,
        type,
        prompt,
        scenario,
        image_url,
        options,
        points,
        sort_order,
        source_master_question_id,
        domain,
        difficulty,
        critical_safety,
        practical_verification_required
      )
      values (
        v_assessment_id,
        v_competency_id,
        v_row.question_type,
        v_row.prompt,
        null,
        null,
        v_row.options,
        1,
        v_row.question_number,
        v_master_question_id,
        'Networking',
        v_row.difficulty,
        true,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Networking L1 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := v_l2_role_id;
  v_assessment_name := 'Networking — Level 2 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_ci_networking_l2_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
    limit 1;

    if v_master_question_id is null then
      insert into public.master_question_bank (
        industry_id,
        master_competency_template_id,
        domain,
        type,
        difficulty,
        prompt,
        options,
        points,
        critical_safety,
        practical_verification_required,
        status,
        version,
        is_current
      )
      values (
        v_industry_id,
        v_competency_id,
        'Networking',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
        false,
        'approved',
        1,
        true
      )
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Networking L2 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_l2_role_id
    )
    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
    limit 1;

    if v_assessment_question_id is null then
      insert into public.assessment_questions (
        assessment_id,
        master_competency_template_id,
        type,
        prompt,
        scenario,
        image_url,
        options,
        points,
        sort_order,
        source_master_question_id,
        domain,
        difficulty,
        critical_safety,
        practical_verification_required
      )
      values (
        v_assessment_id,
        v_competency_id,
        v_row.question_type,
        v_row.prompt,
        null,
        null,
        v_row.options,
        1,
        v_row.question_number,
        v_master_question_id,
        'Networking',
        v_row.difficulty,
        true,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Networking L2 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 3
  -- ========================================================================

  v_level := 3;
  v_role_template_id := v_l3_role_id;
  v_assessment_name := 'Networking — Level 3 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_ci_networking_l3_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
    limit 1;

    if v_master_question_id is null then
      insert into public.master_question_bank (
        industry_id,
        master_competency_template_id,
        domain,
        type,
        difficulty,
        prompt,
        options,
        points,
        critical_safety,
        practical_verification_required,
        status,
        version,
        is_current
      )
      values (
        v_industry_id,
        v_competency_id,
        'Networking',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
        false,
        'approved',
        1,
        true
      )
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Networking L3 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_role_template_id
    )
    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
    limit 1;

    if v_assessment_question_id is null then
      insert into public.assessment_questions (
        assessment_id,
        master_competency_template_id,
        type,
        prompt,
        scenario,
        image_url,
        options,
        points,
        sort_order,
        source_master_question_id,
        domain,
        difficulty,
        critical_safety,
        practical_verification_required
      )
      values (
        v_assessment_id,
        v_competency_id,
        v_row.question_type,
        v_row.prompt,
        null,
        null,
        v_row.options,
        1,
        v_row.question_number,
        v_master_question_id,
        'Networking',
        v_row.difficulty,
        true,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Networking L3 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 4
  -- ========================================================================

  v_level := 4;
  v_role_template_id := v_l4_role_id;
  v_assessment_name := 'Networking — Level 4 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_ci_networking_l4_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
    limit 1;

    if v_master_question_id is null then
      insert into public.master_question_bank (
        industry_id,
        master_competency_template_id,
        domain,
        type,
        difficulty,
        prompt,
        options,
        points,
        critical_safety,
        practical_verification_required,
        status,
        version,
        is_current
      )
      values (
        v_industry_id,
        v_competency_id,
        'Networking',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
        false,
        'approved',
        1,
        true
      )
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Networking L4 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_role_template_id
    )
    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
    limit 1;

    if v_assessment_question_id is null then
      insert into public.assessment_questions (
        assessment_id,
        master_competency_template_id,
        type,
        prompt,
        scenario,
        image_url,
        options,
        points,
        sort_order,
        source_master_question_id,
        domain,
        difficulty,
        critical_safety,
        practical_verification_required
      )
      values (
        v_assessment_id,
        v_competency_id,
        v_row.question_type,
        v_row.prompt,
        null,
        null,
        v_row.options,
        1,
        v_row.question_number,
        v_master_question_id,
        'Networking',
        v_row.difficulty,
        true,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Networking L4 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

end;
$$;

commit;

-- ============================================================================
-- VERIFICATION 1 — EXACT PER-LEVEL PRODUCTION COUNTS
-- Expected:
--   Level 1 -> 20 / 20 / 8 / 8 / 4
--   Level 2 -> 20 / 20 / 5 / 9 / 6
--   Level 3 -> 20 / 20 / 4 / 7 / 9
--   Level 4 -> 20 / 20 / 3 / 7 / 10
-- ============================================================================

select
  a.target_level,
  a.id as assessment_id,
  a.name as assessment_name,
  count(distinct aq.id)::integer as question_count,
  count(distinct ak.question_id)::integer as answer_key_count,
  count(distinct aq.id) filter (where aq.difficulty = 'foundational')::integer as foundational_count,
  count(distinct aq.id) filter (where aq.difficulty = 'application')::integer as application_count,
  count(distinct aq.id) filter (where aq.difficulty = 'scenario')::integer as scenario_count
from public.assessments a
left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id =
   '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
  and a.target_level in (1,2,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 Installer / Helper      -> 20
--   Level 2 Design & Sales Engineer -> 20
--   Level 3 Service & Repair        -> 20
--   Level 4 Senior / Lead           -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 1 and ra.master_role_template_id =
    '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid)
  or
  (q.target_level = 2 and ra.master_role_template_id =
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid;

-- ============================================================================
-- VERIFICATION 4 — NO DUPLICATE CURRENT ASSESSMENTS PER TARGET LEVEL
-- Expected: zero rows
-- ============================================================================

select
  a.target_level,
  count(*) as current_assessment_count
from public.assessments a
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
